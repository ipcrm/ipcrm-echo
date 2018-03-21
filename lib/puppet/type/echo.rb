Puppet::Type.newtype(:echo) do
  @doc = <<-EOT
    This type prints your message as a Notice in your report without
    logging a change
  EOT

  newparam(:message) do
    isnamevar
    desc "This is the content we will actually print.  If omitted the name will be printed"
  end

  newparam(:withpath) do
    desc "Whether to show the full object path. Defaults to true."
    defaultto :true

    newvalues(:true, :false)
  end

  validate do
    output if self[:refreshonly] == :false
  end

  newparam(:refreshonly) do
    defaultto :false
    newvalues(:true, :false)
  end

  def refresh
    output
  end

  def output
    msg = self[:message]
    if parameters[:withpath].value != :false
      msg = "#{self.path}/message: #{msg}"
    end
    Puppet.notice(msg)
  end
end

