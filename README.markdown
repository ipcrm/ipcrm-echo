#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Known Issues](#issues)

## Overview

The purpose of the module is really to add the `echo` type.  This type allows you to print a message to your report WITHOUT logging a change.

## Module Description

You would use this module to print messages to your reports that will only issue a notice and does not get flagged as a change.

## Usage
Usage is super basic and follows that of the notify type.  You can use echo with the `message` parameter and it will print the value of `message`, or
if omitted it will just print the title.


```puppet
echo {'TestMessage':
  message => 'Test message'
}
```

The expected output looks like this:

```
Notice: /Echo[TestMessage]/message: Test message
```

You can optionally provide the `withpath` parameter to control whether or not the resource path is displayed:

```puppet
echo {'TestMessageNoPath':
  message  => 'Test message',
  withpath => false
}
```

The expected output looks like this:

```
Notice: Test message
```

## Issues
There are no tests.


