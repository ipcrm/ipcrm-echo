Puppet::Type.newtype(:echo) do
  @doc = <<-DOC
    This type prints your message as a Notice in your report without
    logging a change
  DOC

  newparam(:name) do
    desc 'The name of the resource. This will be used if the `message` parameter isn\'t given'
  end

  newparam(:message) do
    desc 'This is the content we will actually print.  If omitted the name will be printed'
  end

  newparam(:withpath) do
    desc 'Whether to show the full object path. Defaults to true.'
    defaultto :true

    newvalues(:true, :false)
  end

  validate do
    output if self[:refreshonly] == :false && scheduled?
  end

  newparam(:refreshonly) do
    defaultto :false
    newvalues(:true, :false)
  end

  newparam(:loglevel) do
    defaultto :notice
    newvalues(:debug, :info, :notice, :warning, :err, :alert, :emerg, :crit)
  end

  def refresh
    output
  end

  def output
    msg = self[:message] || self[:name]
    if parameters[:withpath].value != :false
      msg = "#{path}/message: #{msg}"
    end
    Puppet.public_send(self[:loglevel], msg)
  end

  def scheduled?
    name = self[:schedule]
    return true if name.to_s == ''
    scheduler = catalog.resource(:schedule, name) || raise(_('Could not find schedule %{name}') % { name: name })
    scheduler.match?
  end
end
