#include "csdl.h"
#include "opcode_utils.h"

#define OPCODE_NAME "henon"
#define OPCODE_MULTICORE_FLAGS 0
#define OPCODE_ACTIVE OPCODE_ITIME | OPCODE_KTIME
#define OPCODE_INTYPE "kkkii"
#define OPCODE_OUTTYPE "kk"

typedef struct _henon {
  OPDS h;
  /* outputs: */
  MYFLT *x;
  MYFLT *y;
  /* inputs: */
  MYFLT *trig;
  MYFLT *a;
  MYFLT *b;
  MYFLT *x0;
  MYFLT *y0;
  /* local state: */
  MYFLT xm1, ym1;
} henon;

static int op_init(CSOUND *csnd, henon *h)
{
  (*h->x) = *(h->x0);
  (*h->y) = *(h->y0);
  return OK;
}

static int op_k(CSOUND *csnd, henon *h)
{
  if (*(h->trig)) {
    h->xm1 = *(h->x);
    h->ym1 = *(h->y);
    MYFLT xsq = h->xm1 * h->xm1;
    *(h->x) = h->ym1 + (MYFLT)1  - (*(h->a) * xsq);
    *(h->y) = *(h->b) * h->xm1;
  }
  return OK;
}

static OENTRY localops[] = {
  { 
    OPCODE_NAME, 
    sizeof(henon), 
    OPCODE_MULTICORE_FLAGS, 
    OPCODE_ACTIVE, 
    OPCODE_OUTTYPE, 
    OPCODE_INTYPE, 
    (SUBR)op_init, 
    (SUBR)op_k ,
    NULL
  }
};

LINKAGE
