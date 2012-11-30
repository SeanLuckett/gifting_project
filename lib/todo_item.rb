class TodoItem
  attr_reader :explanation, :task

  def initialize(task, explanation)
    @task = task
    @explanation = explanation
  end
end
