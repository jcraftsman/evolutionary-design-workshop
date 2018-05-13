# Evolutionary design workshop

## Experiment deductive approach

In this repo you will find all the meterials you need for "Real world Evolutionary Design with Python" hands-on.

[The slides are available here.](http://slides.com/wasselalazhar/real-world-evolutionary-design-with-python)

## Get started

After cloning this repo, all you need to do is to launch the script `start_workshop.sh`

```bash
./start_workshop.sh
```

This will generate `pictures-analyzer` project in the same directory.

```bash
evolutionary-design-workshop
├── README.md
├── pictures-analyzer
│   ├── Makefile
│   ├── README.md
│   ├── pictures_analyzer
│   │   ├── __init__.py
│   │   ├── __main__.py
│   │   ├── analyzer.py
│   │   ├── safe_box.py
│   │   └── search_engine.py
│   ├── pictures_analyzer_tests
│   │   ├── __init__.py
│   │   └── acceptance
│   │       ├── __init__.py
│   │       ├── pictures
│   │       │   └── top_secret.png
│   │       └── test_analyzer.py
│   ├── requirements_dev.txt
│   └── setup.py
└── start_workshop.sh
```

Move to the generated project, and open it using your favourite IDE.

```bash
cd pictures-analyzer
```

> Something went wrong?
>
>Take a look at "[Need help?](#need-help)" section. You're may be missing some [prerequisites](#prerequisites).

## Iteration 1: Micro design

* Time: 30 min
* Definition of done:
  * Make the acceptance test pass
  * Or, at least, implement `Analyzer.index()` method
* Rules:
  1. Write one first unit test at the top
  1. Whenever your test or implementation needs something, create a stub
  1. Write the next unit test until you reach the bottom layer
* Constraints:
    1. TDD:
        * RED: Write only one failing unit test at time
        * GREEN: Write only enough amount of code to make this failing test pass
        * REFACTOR: Clean up the mess you just made (Think about naming, magic values, non accidental duplication...)
    1. In `analyzer.py`, you cannot import any external library (i.e., you can only import from `pictures_analyzer` module).
    1. You should never modify the given acceptance test. Therefore, you can modify the setup section of this test if needed.
* Hints:
  * Run all the tests

   ```bash
      make tests
   ```

  * You should have only one failing test. It is an acceptance test.
  * Take a look to this test and understand what is missing.
  * This test should guide your implementation.

## Iteration 2: Macro design

* Time: 20 min
* Goal:
  * Think about a better way to restructure python files in packages.
  * Take advantage of the test harness to refactor.
* Hints:
  * Get the code

  ```bash
  ./start_workshop.sh 2
  cd pictures-analyzer
  ```

  * Now the acceptance test is passing.

  ```bash
  make tests
  ```

  * Take a look to the implementation.
  * What do you like about this implementation?
  * What would you do better?
  * Identify where the external libraries are imported.

## Need help?

### Prerequisites

In this workshop you will need:

* Git (obviously)
* Python 3.5+
* Virtualenv

#### Mac OS

The simplest way to install python3 and virtualenv is to rely on hombrew and pip.

```bash
brew update
brew install python3
pip3 install virtualenv
```

This implies that you have xcode, Homebrew and pip3 installed.
If you miss some of these pre-requisites, you can take a look [here](https://www.digitalocean.com/community/tutorials/how-to-install-python-3-and-set-up-a-local-programming-environment-on-macos)
for a more exhaustive setup instructions.

After installation, the version of python3 on your computer should be higher than 3.5

```bash
python3 --version
```

#### Ubuntu

Here are the instructions to install python 3.6 from PPA:

```bash
apt-get install software-properties-common python-software-properties
add-apt-repository ppa:jonathonf/python-3.6
# and press enter to continue.
apt-get update
apt-get install python3.6
pip3 install virtualenv
```

For further details, take a look [here](https://www.rosehosting.com/blog/how-to-install-python-3-6-on-ubuntu-16-04).
