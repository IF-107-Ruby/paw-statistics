class ColumnStruct < BaseModelStruct
  attr_accessor :id, :name, :project_url, :updated_on_github_at

  def initialize(params)
    @id = params[:id]
    @name = params[:name]
    @project_url = params[:project_url]
    @updated_on_github_at = params[:updated_at]
    @project = params[:project]
  end

  def project
    @project ||= ProjectStruct.from_url(project_url)
  end

  def to_params
    params = main_params
    project.is_a?(ApplicationRecord) && params.merge!(project: project)
    params
  end

  alias to_hash to_params

  private

  def main_params
    {
      id: id,
      name: name,
      updated_on_github_at: updated_on_github_at
    }
  end
end
