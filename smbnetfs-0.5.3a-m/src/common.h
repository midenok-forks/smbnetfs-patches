#ifndef __COMMON_H__
#define	__COMMON_H__

#include "config.h"
#include <sys/types.h>
#include <unistd.h>
#include <time.h>
#include <sys/time.h>

/* gcc specific extension. does nothing on other compilers */
#if defined(__GNUC__)
  #define ATTRIB(x) __attribute__ (x)
#else
  #define ATTRIB(x) /* no attributes */
#endif

int  common_get_smbnetfs_debug_level(void);
int  common_set_smbnetfs_debug_level(int level);
int  common_set_log_file(const char *logfile);

void common_debug_print(const char *fmt, ...) ATTRIB((format(printf, 1, 2)));
void common_print_backtrace(void);

extern int common_debug_level;

#define DEBUG_PRINT(level, fmt, args...) \
        if ((level >= 0) && (level <= common_debug_level)) { \
	    struct timeval __now; \
	    gettimeofday(&__now, NULL); \
	    char __tstamp[16]; \
	    struct tm __tm; \
	    localtime_r(&__now.tv_sec, &__tm); \
	    strftime(__tstamp, 16, "%b %d %T", &__tm); \
	    common_debug_print("%.15s.%03d " fmt, __tstamp, (int)__now.tv_usec / 1000, ## args); \
         }

#ifdef PRINTF_DEBUG
  #include <stdio.h>
  #define	DPRINTF(level, fmt, args...)	{ fprintf(stderr, "%d->%s: " fmt, getpid(), __FUNCTION__, ## args); fflush(stderr); }
#else
  #define	DPRINTF(level, fmt, args...) DEBUG_PRINT(level, "%d->%s: " fmt, getpid(), __FUNCTION__, ## args);
#endif

#ifndef HAVE_STRNDUP
  char* strndup(const char *s, size_t n);
#endif

#endif /* __COMMON_H__ */
