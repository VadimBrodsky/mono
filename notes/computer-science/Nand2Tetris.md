# Nand 2 Tetris

Its possible to build a computer with just one gate `NAND` or `NOR`.

## Elementary Logic Gates

### NAND

```
if (a==1 and b==1)
then out=0 else out=1
```

### AND

```
if (a==1 and b==1)
then out=1 else out=0
```

### OR

```
if (a==1 or b==1)
then out=1 else out=0
```

### NOT

```
if (in==0)
then out=1 else out=0
```

## Composite Gates

### 3-way AND

```
if (a==1 and b==1 and c==1)
then out=1 else out=0
```

### XOR

```
if (a==1 or b==1 and a==0 and b==0)
then out=0 else out=1
```

## HDL - Hardware Description Language
A definition language for chips and their implementations. An HDL file is a textual description of the HDL diagram.

- A function and declarative language, with no procedures or runtime execution.
- HDL allows unlimited fan-outs of a single input simultaneously to as many destinations as we want.
- The order of HDL statements is insignificant.
- Before using a chip part, you must know its interface.
- Connections like `partName(a=a,...)` and `partName(...out=out)` are common.

Most common HDL languages are VHDL and Verilog.

### Chip Implementation

```hdl
/** Xor gate: out = (a And Not(b)) Or (Not(a) And b) */

CHIP Xor {
  IN a,b;
  OUT out;

  PARTS:
  Not (in=a, out=nota);
  Not (in=b, out=notb);
  And (a=a, b=notb, out=aAndNotb);
  And (a=nota, b=b, out=notaAndb);
  Or  (a=aAndNotb, b=notaAndb, out=out);
}
```

### Chip Test Script

To test a chip implementation its useful to write a test script, example `Xor.tst`:

```
load Xor.hdl;
output-file Xor.out;
compare-to Xor.cmp;
output-list a b out;
set a 0, set b 0, eval, output;
set a 0, set b 1, eval, output;
set a 1, set b 0, eval, output;
set a 1, set b 1, eval, output;
```

### Chip Compare File

Additional tool to verify the correctness of a chip implementation is a compare file, example :`Xor.cmp`, it compares the output of the test script to a desired output. Its an output of a correctly behaving chip that we want to compare against. This process if called behavioral simulation.

```
| a | b |out|
| 0 | 0 | 0 |
| 0 | 1 | 1 |
| 1 | 0 | 1 |
| 1 | 1 | 0 |
```

## Multi-Bit Busses

### Array of Bits
- Sometimes we manipulate "together" an array of bits
- It is conceptually convenient to think about such a group of bits as a single entity, sometimes
  termed "bus"
- HDLs will usually provide some convenient notation for handling these buses.

Example of an Add chip that works with 16bit numbers

```hdl
/** Adds two 16-bit values. */
CHIP Add16 {
  IN a[16], b[16];
  OUT out[16];

  PARTS:
  // ...
}
```

Same applies to a three way Add with 16 bits


```hdl
/** Adds three 16-bit values. */
CHIP Add3Way16 {
  IN first[16], second[16], third[16];
  OUT out[16];

  PARTS:
  Add16(a=first, b=second, out=temp);
  Add16(a=temp, b=third, out=put)
}
```

We can also go from a bus to a single output, use the 0-based index of the bus.

```hdl
/** ANDs together all 4 bits of the input. */
CHIP And4Way {
  IN a[4];
  OUT out;

  PARTS:
    AND(a=a[0], b=a[1], out=t01])
    AND(a=t01,  b=a[2], out=t012])
    AND(a=t012, b=a[3], out=out)
}
```

We can also do a bit-wise operations operating on all bits at the same time.

```hdl
/** Computes a bit-wise and of its two 4-bit input buses */
CHIP And4 {
  IN a[4], b[4];
  OUT out[4];

  PARTS:
    AND(a=a[0], b=b[0], out=out[0]);
    AND(a=a[1], b=b[1], out=out[1]);
    AND(a=a[2], b=b[2], out=out[2]);
    AND(a=a[3], b=b[3], out=out[3]);
}
```

Buses can also composed from and broken into sub-basses

Syntactic choices of N2T HDL:
- Overlaps of sub-buses are allowed on output busses of parts
- Width of internal pins is deduced automatically
- False and true may be used as buses of any width

```hdl
...
IN lsb[8], msb[8], ...
...
Add16(a[0..7]=lsb, a[8..15]=msb, b=..., out=...)
Add16(..., out[0..3]=t1, out[4..15]=t2);
```

## Multiplexor
A programmable gate that Uses a `sel` side input to select:
- A 2-way multiplexor enables selecting and outputting one out of two possible inputs.
- Widely used in digital design and communication networks.
- This is usually implemented with a fan-out design where the same input is fed into multiple sub gates.

```
if (sel==0)
  out=a
else
  out=b
````

Implementation:

```hdl
CHIP AndMuxOr {
  IN a,b, sel;
  OUT out;

  PARTS:
  And (a=a, b=b, out=andOut);
  Or  (a=a, b=b, out=orOut);
  Mux (a=andOut, b=orOut, sel=sel, out=out);
}
```

## Demultiplexor
Inverse of a multiplexor, uses a single input and based on the selector bit channels the output to either a or b output.
- Acts like the inverse of a multiplexor
- Distributes the single input value into one of two possible directions

```
if (sel==0)
  {a,b}={in,0}
else
  {a,b}={0,in}
```
