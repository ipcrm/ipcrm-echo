Puppet::Type.newtype(:echo) do
  @doc = <<-EOT
    This type prints your message as a Notice in your report without
    logging a change
  EOT

  newparam(:name) do
    isnamevar
    desc "An arbitrary tag for your own reference; the name of the message."
  end

  newparam(:message) do
    desc <<-EOT
      The message we are printing
    EOT
  end

  validate do
    if parameters[:message].nil?
      msg = parameters[:name].value
    else
      msg = parameters[:message].value
    end

    # Print a message
    Puppet.notice(self.path + "/message: #{msg}")
  end
end

