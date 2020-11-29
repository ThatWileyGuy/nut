dnl Check for current compiler support of specific pragmas we use,
dnl e.g. diagnostics management to keep warnings quiet sometimes

AC_DEFUN([AX_C_PRAGMAS], [
  CFLAGS_SAVED="${CFLAGS}"
  CXXFLAGS_SAVED="${CXXFLAGS}"

  dnl ### To be sure, bolt the language
  AC_LANG_PUSH([C])

  dnl # This is expected to fail builds with unknown pragma names on GCC or CLANG at least
  AS_IF([test "${CLANG}" = "yes"],
    [CFLAGS="${CFLAGS_SAVED} -Werror=pragmas -Werror=unknown-warning-option"
     CXXFLAGS="${CXXFLAGS_SAVED} -Werror=pragmas -Werror=unknown-warning-option"],
    [AS_IF([test "${GCC}" = "yes"],
dnl ### Despite the docs, this dies with lack of (apparently) support for
dnl ### -Wunknown-warning(-options) on all GCC versions I tried (v5-v10)
dnl ###        [CFLAGS="${CFLAGS_SAVED} -Werror=pragmas -Werror=unknown-warning"],
        [CFLAGS="${CFLAGS_SAVED} -Wall -Wextra -Werror"
         CXXFLAGS="${CXXFLAGS_SAVED} -Wall -Wextra -Werror"],
        [CFLAGS="${CFLAGS_SAVED} -Wall -Wextra -Werror"
         CXXFLAGS="${CXXFLAGS_SAVED} -Wall -Wextra -Werror"])
    ])

  AC_CACHE_CHECK([for pragma GCC diagnostic push and pop],
    [ax_cv__pragma__gcc__diags_push_pop],
    [AC_COMPILE_IFELSE(
      [AC_LANG_PROGRAM([[
#pragma GCC diagnostic push
#pragma GCC diagnostic pop
        ]], [])],
      [ax_cv__pragma__gcc__diags_push_pop=yes],
      [ax_cv__pragma__gcc__diags_push_pop=no]
    )]
  )
  AS_IF([test "$ax_cv__pragma__gcc__diags_push_pop" = "yes"],[
    AC_DEFINE([HAVE_PRAGMA_GCC_DIAGNOSTIC_PUSH_POP], 1, [define if your compiler has #pragma GCC diagnostic push and pop])
  ])

  AC_CACHE_CHECK([for pragma GCC diagnostic ignored "-Wformat-nonliteral"],
    [ax_cv__pragma__gcc__diags_ignored_format_nonliteral],
    [AC_COMPILE_IFELSE(
      [AC_LANG_PROGRAM([[#pragma GCC diagnostic ignored "-Wformat-nonliteral"]], [])],
      [ax_cv__pragma__gcc__diags_ignored_format_nonliteral=yes],
      [ax_cv__pragma__gcc__diags_ignored_format_nonliteral=no]
    )]
  )
  AS_IF([test "$ax_cv__pragma__gcc__diags_ignored_format_nonliteral" = "yes"],[
    AC_DEFINE([HAVE_PRAGMA_GCC_DIAGNOSTIC_IGNORED_FORMAT_NONLITERAL], 1, [define if your compiler has #pragma GCC diagnostic ignored "-Wformat-nonliteral"])
  ])

  AC_CACHE_CHECK([for pragma GCC diagnostic ignored "-Wformat-security"],
    [ax_cv__pragma__gcc__diags_ignored_format_security],
    [AC_COMPILE_IFELSE(
      [AC_LANG_PROGRAM([[#pragma GCC diagnostic ignored "-Wformat-security"]], [])],
      [ax_cv__pragma__gcc__diags_ignored_format_security=yes],
      [ax_cv__pragma__gcc__diags_ignored_format_security=no]
    )]
  )
  AS_IF([test "$ax_cv__pragma__gcc__diags_ignored_format_security" = "yes"],[
    AC_DEFINE([HAVE_PRAGMA_GCC_DIAGNOSTIC_IGNORED_FORMAT_SECURITY], 1, [define if your compiler has #pragma GCC diagnostic ignored "-Wformat-security"])
  ])

  AC_CACHE_CHECK([for pragma GCC diagnostic ignored "-Wunreachable-code-break"],
    [ax_cv__pragma__gcc__diags_ignored_unreachable_code_break],
    [AC_COMPILE_IFELSE(
      [AC_LANG_PROGRAM([[#pragma GCC diagnostic ignored "-Wunreachable-code-break"]], [])],
      [ax_cv__pragma__gcc__diags_ignored_unreachable_code_break=yes],
      [ax_cv__pragma__gcc__diags_ignored_unreachable_code_break=no]
    )]
  )
  AS_IF([test "$ax_cv__pragma__gcc__diags_ignored_unreachable_code_break" = "yes"],[
    AC_DEFINE([HAVE_PRAGMA_GCC_DIAGNOSTIC_IGNORED_UNREACHABLE_CODE_BREAK], 1, [define if your compiler has #pragma GCC diagnostic ignored "-Wunreachable-code-break"])
  ])

  AC_CACHE_CHECK([for pragma GCC diagnostic ignored "-Wunreachable-code"],
    [ax_cv__pragma__gcc__diags_ignored_unreachable_code],
    [AC_COMPILE_IFELSE(
      [AC_LANG_PROGRAM([[#pragma GCC diagnostic ignored "-Wunreachable-code"]], [])],
      [ax_cv__pragma__gcc__diags_ignored_unreachable_code=yes],
      [ax_cv__pragma__gcc__diags_ignored_unreachable_code=no]
    )]
  )
  AS_IF([test "$ax_cv__pragma__gcc__diags_ignored_unreachable_code" = "yes"],[
    AC_DEFINE([HAVE_PRAGMA_GCC_DIAGNOSTIC_IGNORED_UNREACHABLE_CODE], 1, [define if your compiler has #pragma GCC diagnostic ignored "-Wunreachable-code"])
  ])

  AC_CACHE_CHECK([for pragma GCC diagnostic ignored "-Wformat-overflow"],
    [ax_cv__pragma__gcc__diags_ignored_format_overflow],
    [AC_COMPILE_IFELSE(
      [AC_LANG_PROGRAM([[#pragma GCC diagnostic ignored "-Wformat-overflow"]], [])],
      [ax_cv__pragma__gcc__diags_ignored_format_overflow=yes],
      [ax_cv__pragma__gcc__diags_ignored_format_overflow=no]
    )]
  )
  AS_IF([test "$ax_cv__pragma__gcc__diags_ignored_format_overflow" = "yes"],[
    AC_DEFINE([HAVE_PRAGMA_GCC_DIAGNOSTIC_IGNORED_FORMAT_OVERFLOW], 1, [define if your compiler has #pragma GCC diagnostic ignored "-Wformat-overflow"])
  ])

  AC_CACHE_CHECK([for pragma GCC diagnostic ignored "-Wcovered-switch-default"],
    [ax_cv__pragma__gcc__diags_ignored_covered_switch_default],
    [AC_COMPILE_IFELSE(
      [AC_LANG_PROGRAM([[#pragma GCC diagnostic ignored "-Wcovered-switch-default"]], [])],
      [ax_cv__pragma__gcc__diags_ignored_covered_switch_default=yes],
      [ax_cv__pragma__gcc__diags_ignored_covered_switch_default=no]
    )]
  )
  AS_IF([test "$ax_cv__pragma__gcc__diags_ignored_covered_switch_default" = "yes"],[
    AC_DEFINE([HAVE_PRAGMA_GCC_DIAGNOSTIC_IGNORED_COVERED_SWITCH_DEFAULT], 1, [define if your compiler has #pragma GCC diagnostic ignored "-Wcovered-switch-default"])
  ])

  AC_CACHE_CHECK([for pragma GCC diagnostic ignored "-Wcast-align"],
    [ax_cv__pragma__gcc__diags_ignored_cast_align],
    [AC_COMPILE_IFELSE(
      [AC_LANG_PROGRAM([[#pragma GCC diagnostic ignored "-Wcast-align"]], [])],
      [ax_cv__pragma__gcc__diags_ignored_cast_align=yes],
      [ax_cv__pragma__gcc__diags_ignored_cast_align=no]
    )]
  )
  AS_IF([test "$ax_cv__pragma__gcc__diags_ignored_cast_align" = "yes"],[
    AC_DEFINE([HAVE_PRAGMA_GCC_DIAGNOSTIC_IGNORED_CAST_ALIGN], 1, [define if your compiler has #pragma GCC diagnostic ignored "-Wcast-align"])
  ])

  AC_CACHE_CHECK([for pragma GCC diagnostic ignored "-Wstrict-prototypes"],
    [ax_cv__pragma__gcc__diags_ignored_strict_prototypes],
    [AC_COMPILE_IFELSE(
      [AC_LANG_PROGRAM([[#pragma GCC diagnostic ignored "-Wstrict-prototypes"]], [])],
      [ax_cv__pragma__gcc__diags_ignored_strict_prototypes=yes],
      [ax_cv__pragma__gcc__diags_ignored_strict_prototypes=no]
    )]
  )
  AS_IF([test "$ax_cv__pragma__gcc__diags_ignored_strict_prototypes" = "yes"],[
    AC_DEFINE([HAVE_PRAGMA_GCC_DIAGNOSTIC_IGNORED_STRICT_PROTOTYPES], 1, [define if your compiler has #pragma GCC diagnostic ignored "-Wstrict-prototypes"])
  ])

  AC_CACHE_CHECK([for pragma GCC diagnostic ignored "-Wassign-enum"],
    [ax_cv__pragma__gcc__diags_ignored_assign_enum],
    [AC_COMPILE_IFELSE(
      [AC_LANG_PROGRAM([[#pragma GCC diagnostic ignored "-Wassign-enum"]], [])],
      [ax_cv__pragma__gcc__diags_ignored_assign_enum=yes],
      [ax_cv__pragma__gcc__diags_ignored_assign_enum=no]
    )]
  )
  AS_IF([test "$ax_cv__pragma__gcc__diags_ignored_assign_enum" = "yes"],[
    AC_DEFINE([HAVE_PRAGMA_GCC_DIAGNOSTIC_IGNORED_ASSIGN_ENUM], 1, [define if your compiler has #pragma GCC diagnostic ignored "-Wassign-enum"])
  ])

  AC_LANG_POP([C])

  dnl ### Series of tests for C++ specific pragmas
  AC_LANG_PUSH([C++])

  AC_CACHE_CHECK([for C++ pragma GCC diagnostic ignored "-Wc++98-compat-pedantic"],
    [ax_cv__pragma__gcc__diags_ignored_cxx98_compat_pedantic],
    [AC_COMPILE_IFELSE(
      [AC_LANG_PROGRAM([[#pragma GCC diagnostic ignored "-Wc++98-compat-pedantic"]], [])],
      [ax_cv__pragma__gcc__diags_ignored_cxx98_compat_pedantic=yes],
      [ax_cv__pragma__gcc__diags_ignored_cxx98_compat_pedantic=no]
    )]
  )
  AS_IF([test "$ax_cv__pragma__gcc__diags_ignored_cxx98_compat_pedantic" = "yes"],[
    AC_DEFINE([HAVE_PRAGMA_GCC_DIAGNOSTIC_IGNORED_CXX98_COMPAT_PEDANTIC], 1, [define if your compiler has #pragma GCC diagnostic ignored "-Wc++98-compat-pedantic"])
  ])

  AC_CACHE_CHECK([for C++ pragma GCC diagnostic ignored "-Wc++98-compat"],
    [ax_cv__pragma__gcc__diags_ignored_cxx98_compat],
    [AC_COMPILE_IFELSE(
      [AC_LANG_PROGRAM([[#pragma GCC diagnostic ignored "-Wc++98-compat"]], [])],
      [ax_cv__pragma__gcc__diags_ignored_cxx98_compat=yes],
      [ax_cv__pragma__gcc__diags_ignored_cxx98_compat=no]
    )]
  )
  AS_IF([test "$ax_cv__pragma__gcc__diags_ignored_cxx98_compat" = "yes"],[
    AC_DEFINE([HAVE_PRAGMA_GCC_DIAGNOSTIC_IGNORED_CXX98_COMPAT], 1, [define if your compiler has #pragma GCC diagnostic ignored "-Wc++98-compat"])
  ])

  AC_CACHE_CHECK([for C++ pragma GCC diagnostic ignored "-Wglobal-constructors"],
    [ax_cv__pragma__gcc__diags_ignored_global_constructors],
    [AC_COMPILE_IFELSE(
      [AC_LANG_PROGRAM([[#pragma GCC diagnostic ignored "-Wglobal-constructors"]], [])],
      [ax_cv__pragma__gcc__diags_ignored_global_constructors=yes],
      [ax_cv__pragma__gcc__diags_ignored_global_constructors=no]
    )]
  )
  AS_IF([test "$ax_cv__pragma__gcc__diags_ignored_global_constructors" = "yes"],[
    AC_DEFINE([HAVE_PRAGMA_GCC_DIAGNOSTIC_IGNORED_GLOBAL_CONSTRUCTORS], 1, [define if your compiler has #pragma GCC diagnostic ignored "-Wglobal-constructors"])
  ])

  AC_CACHE_CHECK([for C++ pragma GCC diagnostic ignored "-Wexit-time-destructors"],
    [ax_cv__pragma__gcc__diags_ignored_exit_time_destructors],
    [AC_COMPILE_IFELSE(
      [AC_LANG_PROGRAM([[#pragma GCC diagnostic ignored "-Wexit-time-destructors"]], [])],
      [ax_cv__pragma__gcc__diags_ignored_exit_time_destructors=yes],
      [ax_cv__pragma__gcc__diags_ignored_exit_time_destructors=no]
    )]
  )
  AS_IF([test "$ax_cv__pragma__gcc__diags_ignored_exit_time_destructors" = "yes"],[
    AC_DEFINE([HAVE_PRAGMA_GCC_DIAGNOSTIC_IGNORED_EXIT_TIME_DESTRUCTORS], 1, [define if your compiler has #pragma GCC diagnostic ignored "-Wexit-time-destructors"])
  ])

  AC_LANG_POP([C++])

  dnl # Meta-macros for simpler use-cases where we pick
  dnl # equivalent-effect macros for different compiler versions
  AS_IF([test "$ax_cv__pragma__gcc__diags_push_pop" = "yes"],[
    AS_IF([test "$ax_cv__pragma__gcc__diags_ignored_format_security" = "yes" || test "$ax_cv__pragma__gcc__diags_ignored_format_nonliteral" = "yes" ],[
        AC_DEFINE([HAVE_PRAGMAS_FOR_GCC_DIAGNOSTIC_IGNORED_FORMAT_NONLITERAL], 1, [define if your compiler has pragmas for GCC diagnostic ignored "-Wformat-nonliteral" or "-Wformat-security" and for push-pop support])
    ])
    AS_IF([test "$ax_cv__pragma__gcc__diags_ignored_unreachable_code" = "yes" || test "$ax_cv__pragma__gcc__diags_ignored_unreachable_code_break" = "yes" ],[
        AC_DEFINE([HAVE_PRAGMAS_FOR_GCC_DIAGNOSTIC_IGNORED_UNREACHABLE_CODE], 1, [define if your compiler has pragmas for GCC diagnostic ignored "-Wunreachable-code(-break)" and for push-pop support])
    ])
    AS_IF([test "$ax_cv__pragma__gcc__diags_ignored_cxx98_compat_pedantic" = "yes" || test "$ax_cv__pragma__gcc__diags_ignored_cxx98_compat" = "yes" ],[
        AC_DEFINE([HAVE_PRAGMAS_FOR_GCC_DIAGNOSTIC_IGNORED_CXX98_COMPAT], 1, [define if your compiler has pragmas for GCC diagnostic ignored "-Wc++98-compat(-pedantic)" and for push-pop support])
    ])
  ])

  dnl ### Sanity check if the CLI options actually work:
  AC_CACHE_CHECK([for pragma BOGUSforTest],
    [ax_cv__pragma__bogus],
    [AC_COMPILE_IFELSE(
      [AC_LANG_PROGRAM([[#pragma BOGUSforTest]], [])],
      [ax_cv__pragma__bogus=yes],
      [ax_cv__pragma__bogus=no]
    )]
  )

  AC_CACHE_CHECK([for pragma GCC diagnostic ignored "-WBOGUSforTest"],
    [ax_cv__pragma__bogus_diag],
    [AC_COMPILE_IFELSE(
      [AC_LANG_PROGRAM([[#pragma GCC diagnostic ignored "-WBOGUSforTest"]], [])],
      [ax_cv__pragma__bogus_diag=yes],
      [ax_cv__pragma__bogus_diag=no]
    )]
  )

  AS_IF([test "${ax_cv__pragma__bogus}" != "no"],
    [AC_MSG_WARN([A bogus test that was expected to fail did not! ax_cv__pragma__bogus=$ax_cv__pragma__bogus (not 'no')])])

  AS_IF([test "${ax_cv__pragma__bogus_diag}" != "no"],
    [AC_MSG_WARN([A bogus test that was expected to fail did not! ax_cv__pragma__bogus_diag=$ax_cv__pragma__bogus_diag (not 'no')])])

  CFLAGS="${CFLAGS_SAVED}"
  CXXFLAGS="${CXXFLAGS_SAVED}"
])

AC_DEFUN([AX_C_PRINTF_STRING_NULL], [
  dnl ### To be sure, bolt the language
  AC_LANG_PUSH([C])

  AC_CACHE_CHECK([for practical support to pritnf("%s", NULL)],
    [ax_cv__printf_string_null],
    [AC_RUN_IFELSE(
        [AC_LANG_PROGRAM([dnl
#include <stdio.h>
#include <strings.h>
], [dnl
char buf[128];
char *s = NULL;
int res = snprintf(buf, sizeof(buf), "%s", s);
buf[sizeof(buf)-1] = '\0';
if (res < 0) {
    printf(stderr, "FAILED to snprintf() a NULL string argument");
    exit 1;
}
if (buf[0] == '\0')
    printf(stderr, "RETURNED empty string from snprintf() with a NULL string argument");
    exit 0;
}
if (strcasestr(buf, 'null') == NULL)
    printf(stderr, "RETURNED some string from snprintf() with a NULL string argument: '%s'", buf);
    exit 0;
}
printf(stderr, "SUCCESS: RETURNED a string that contains something like 'null' from snprintf() with a NULL string argument: '%s'", buf);
exit 0;
            ])],
        [ax_cv__printf_string_null=yes],
        [ax_cv__printf_string_null=no]
    )]
  )

  AS_IF([test "$ax_cv__printf_string_null" = "yes"],[
    AC_DEFINE([HAVE_PRINTF_STRING_NULL], 1, [define if your libc can printf("%s", NULL) sanely])
  ])

  AC_LANG_POP([C])
])
