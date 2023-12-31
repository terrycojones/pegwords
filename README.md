# Pegwords

I read Harry Lorayne's book [How to Develop a Super Power
Memory](https://www.amazon.com/How-Develop-Super-Power-Memory/dp/0811901815)
back in about 1979 and spent a lot of time becoming quite good at
memorizing numbers by turning them in words using the "phonetic alphabet"
therein.

Last night I decided to write a couple of quick scripts to make it easy to
pick a sequence of long words to memorize.

## Installation

```sh
$ pip install pegwords
```

## Usage

There are two scripts here:

### Making a list of words given a sequence of digits

To memorize a number, you need to convert it to a sequence of memorable
words to be visualized. Sequences can be constructed using
`digits-to-words.py`.

The script is interactive. Here's how to try it out on the first 50 decmial
places of Pi:

```sh
$ ./digits-to-words.py 14159265358979323846264338327950288419716939937510
```

The program will read `/usr/share/dict/web2` (or pass a dictionary file
using `--dictionaryFile`) and will then prompt you to pick one word at a
time to build a sequence of words matching the given string of digits.

At each step you can type:

* A number to choose your next word from the current list of candidates.
* `?` to see the current list.
* `-` to make the matched prefix one character shorter (= more words to choose from).
* `+` to make the matched prefix one character longer (= fewer words to choose from).
* `q` to quit.

### Getting the sequence of digits for a list of words

Simpler is to go the other way, converting a sequence of words into their
corresponding digits:

```sh
$ ./words-to-digits.py hello world
4 digits (5451) covered by 2 words:
  DIGITS: 5     451
  WORDS:  hello world
```

You can also check if a sequence of words has the expected digit sequence:

```
$ ./words-to-digits.py --expected 5456 hello world
4 digits (5451) covered by 2 words:
  DIGITS: 5     451
  WORDS:  hello world
Result '5451' does not match expected '5456'!
EXPECTED: 5456
             |
RECEIVED: 5451
For word 'world', expected '456' but the correct value is '451'.
```

The output shows you the mismatch (or mismatches) in digit sequences and
also the corresponding words. If the expected value correctly matches the
computed value, nothing is is printed.

## Notes

### Tests

To run the tests, make sure you have `pytest` installed, then:

```sh
$ make test
```

### Accuracy

The method of converting words to digit sequences is crude, using simple
regular expressions. It will for sure make mistakes.

If you see something wrong, the easiest way to begin to find the cause will
be to add a test to `test/test_words.py`. Just do something like this:

```python
def testWhale():
    assert wordToDigits("whale", verbose=True) == "5"
```

This will cause debugging output to be printed, allowing you to (hopefully)
figure out which regular expression matched (or didn't) and why you're
seeing the result you see.

Maybe you can then fix it and send a pull request, or open a GitHub issue
with the failing test, etc.
