#include<iostream>
#include<Windows.h>
using namespace std;
void printProcessPrty(HANDLE h) {
	DWORD prty = GetPriorityClass(h);
	cout << "------CURRENT PID: " << GetCurrentProcessId() << endl;
	switch (prty) {
		case IDLE_PRIORITY_CLASS: cout << "---+ priority is IDLE_PRIORITY_CLASS" << endl; break;
		case BELOW_NORMAL_PRIORITY_CLASS: cout << "---+ priority is BELOW_NORMAL_PRIORITY_CLASS" << endl; break;
		case NORMAL_PRIORITY_CLASS:  cout << "---+ priority is NORMAL_PRIORITY_CLASS" << endl; break;
		case ABOVE_NORMAL_PRIORITY_CLASS:  cout << "---+ priority is ABOVE_NORMAL_PRIORITY_CLASS" << endl; break;
		case HIGH_PRIORITY_CLASS:  cout << "---+ priority is HIGH_PRIORITY_CLASS" << endl; break;
		case REALTIME_PRIORITY_CLASS:  cout << "---+ priority is REALTIME_PRIORITY_CLASS" << endl; break;
		default:  cout << "---+ priority is UNKNOWN" << endl; break;
	}
	return;
}
void printThreadPrty(HANDLE h) {
	DWORD prty = GetThreadPriority(h);
	cout << "------CURRENT TID: " << GetCurrentThreadId() << endl;
	switch (prty) {
	case THREAD_PRIORITY_LOWEST: cout << "---+ priority is THREAD_PRIORITY_LOWEST" << endl; break;
	case THREAD_PRIORITY_BELOW_NORMAL: cout << "---+ priority is THREAD_PRIORITY_BELOW_NORMAL" << endl; break;
	case THREAD_PRIORITY_NORMAL:  cout << "---+ priority is THREAD_PRIORITY_NORMAL" << endl; break;
	case THREAD_PRIORITY_ABOVE_NORMAL:  cout << "---+ priority is THREAD_PRIORITY_ABOVE_NORMAL" << endl; break;
	case THREAD_PRIORITY_HIGHEST:  cout << "---+ priority is THREAD_PRIORITY_HIGHEST" << endl; break;
	case THREAD_PRIORITY_IDLE:  cout << "---+ priority is THREAD_PRIORITY_IDLE" << endl; break;
	case THREAD_PRIORITY_TIME_CRITICAL:  cout << "---+ priority is THREAD_PRIORITY_TIME_CRITICAL" << endl; break;
	default:  cout << "---+ priority is UNKNOWN" << endl; break;
	}
	return;
}
void PrintAffinityMask(HANDLE hp, HANDLE ht) {
	DWORD_PTR pa = NULL, sa = NULL, icpu = -1;
	if (!GetProcessAffinityMask(hp, &pa, &sa)) {
		throw "GetProcessAffinityMask is ended with error!";
	}
	cout << "Process Affinity Mask: " << showbase << hex << pa << endl;
	cout << "System Affinity Mask: " << showbase << hex << sa << endl;
	SYSTEM_INFO sysinf;
	GetSystemInfo(&sysinf);
	cout << "Max process count: " << sysinf.dwNumberOfProcessors << endl;
	icpu = SetThreadIdealProcessor(ht, MAXIMUM_PROCESSORS);
	std::cout << "Thread Ideal Processor: " << dec << icpu << endl;

}
int main() {
	HANDLE hp = GetCurrentProcess();
	HANDLE ht = GetCurrentThread();
	DWORD pid = GetCurrentProcessId();
	DWORD tid = GetCurrentThreadId();
	cout << "------------------------------------------" << endl;
	cout << "------CURRENT PID: " << pid << endl;
	cout << "------CURRENT TID: " << tid << endl;
	printProcessPrty(hp);
	printThreadPrty(ht);
	cout << endl;
	PrintAffinityMask(hp, ht);
	cout << "------------------------------------------" << endl;
	system("pause");
}