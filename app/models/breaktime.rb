class Breaktime < Hack

  after_initialize :default_values

  def presenting?
    true
  end

private

  def default_values
    self.title = 'BREAK'
    self.description = 'BREAK TIME'
    self.breaktime = true
  end

end