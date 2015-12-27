/* How to Hook with Logos
Hooks are written with syntax similar to that of an Objective-C @implementation.
You don't need to #include <substrate.h>, it will be done automatically, as will
the generation of a class list and an automatic constructor.

%hook ClassName

// Hooking a class method
+ (id)sharedInstance {
	return %orig;
}

// Hooking an instance method with an argument.
- (void)messageName:(int)argument {
	%log; // Write a message about this call, including its class, name and arguments, to the system log.

	%orig; // Call through to the original function with its original arguments.
	%orig(nil); // Call through to the original function with a custom argument.

	// If you use %orig(), you MUST supply all arguments (except for self and _cmd, the automatically generated ones.)
}

// Hooking an instance method with no arguments.
- (id)noArguments {
	%log;
	id awesome = %orig;
	[awesome doSomethingElse];

	return awesome;
}

// Always make sure you clean up after yourself; Not doing so could have grave consequences!
%end
*/


#import <substrate.h>
#import <mach-o/dyld.h>
#import <dlfcn.h>
#import "header.h"


/*
// these
int fake_ptrace(int request, pid_t pid, caddr_t addr, int data){
	return 0;
}

void *(*old_dlsym)(void *handle, const char *symbol);

void *my_dlsym(void *handle, const char *symbol){
	if(strcmp(symbol,"ptrace") == 0){
		return (void*)fake_ptrace;
	}

	return old_dlsym(handle,symbol);
}

%ctor{
	MSHookFunction((void*)dlsym,(void*)my_dlsym,(void**)&old_dlsym);
}
*/

// or these
static int (*oldptrace)(int request, pid_t pid, caddr_t addr, int data);
static int newptrace(int request, pid_t pid, caddr_t addr, int data){
	return 0; // just return zero
/*
	// or return oldptrace with request -1
	if (request == 31) {
		request = -1;
	}
	return oldptrace(request,pid,addr,data);
*/
}


%ctor {
	MSHookFunction((void *)MSFindSymbol(NULL,"_ptrace"), (void *)newptrace, (void **)&oldptrace);
}


static APVoiceManager *s_voiceManager;

%hook CTMessageCell

%new
- (void)evt_alert:(id)msg{
	UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:@""
                                                message:[NSString stringWithFormat:@"%@",msg]
                                                delegate:self
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles: nil];
    [alert show];
}

- (void)collectMenu:(id)arg1{
	self.backgroundColor = [UIColor greenColor];

	UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
	pasteboard.string = self.voiceObj.url;


	if(!s_voiceManager){
		[self evt_alert:@"voice manager null"];
		return;
	}

	NSData *voiceData = [s_voiceManager.voiceCache queryVoiceDataForKey:self.voiceObj.url formatType:1];

	if(!voiceData){
		[self evt_alert:@"Can not get voice data from cache"];
		return;
	}

    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *url = (id)[[fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];
    
    NSString *voiceDir = [[url path] stringByAppendingPathComponent:@"voice"];
    if(![fileManager fileExistsAtPath:voiceDir]){
        if(![fileManager createDirectoryAtPath:voiceDir withIntermediateDirectories:YES attributes:nil error:nil]){
        	[self evt_alert:@"error create dir"];
        	return;
        }
    }
    
    NSString *filePath = [voiceDir stringByAppendingPathComponent:@"voicedata.wav"];
    if([voiceData writeToFile:filePath atomically:YES]){
    	NSString *msg = [NSString stringWithFormat:@"succeed saved to %@",filePath];
    	[self evt_alert:msg];
    }else{
    	[self evt_alert:@"failed to save"];
    }
}


%end

%hook APVoiceManager

+ (id)sharedManager{
	if(!s_voiceManager){
		s_voiceManager = %orig;
		return s_voiceManager;
	}
	return %orig;
}
%end
