#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
4. [Usage - Configuration options and additional functionality](#usage)

## Overview

The purpose of the module is really to add the `echo` type.  This type allows you to print a message to your report WITHOUT logging a change.

## Module Description

You would use this module to print messages to your reports that will only issue a notice and does not get flagged as a change.

## Usage

```puppet
echo {'TestMessage':
  message => 'Test message'
}
```

The expected output looks like this:

```
Notice: Echo/[TestMessage]/message: This is a test message
```

