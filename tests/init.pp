echo{'TestMessage':
  message => 'This is a test message',
}

echo{'TestMessageWithNoPath':
  message  => 'This is a test message that should not have the resource path prepended.',
  withpath => false,
}
