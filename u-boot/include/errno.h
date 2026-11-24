#ifdef USE_HOSTCC
#include_next <errno.h>
#else
#ifndef _ERRNO_H
#define _ERRNO_H

#include <asm-generic/errno.h>

extern int errno;

#define __set_errno(val) do { errno = val; } while (0)

#endif /* _ERRNO_H */
#endif /* USE_HOSTCC */