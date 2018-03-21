Puppet::Type.newtype(:echo) do
  @doc = <<-EOT
    This type prints your message as a Notice in your report without
    logging a change
  EOT

  newparam(:message) do
    isnamevar
    desc "This is the content we will actually print.  If omitted the name will be printed"
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
    Puppet.notice(self.path + "/message: #{self[:message]}")
  end
end

