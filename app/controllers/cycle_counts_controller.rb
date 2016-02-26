class CycleCountsController < ApplicationController
  include BasicCRUDHandler
  before_action -> { authorize :cycle_count }
  respond_to :html

  def index
    render_index
  end

  def show
    render_show
  end

  def new
    render_new
  end

  def edit
    render_edit
  end

  def destroy
    if cycle_count.destroy
      redirect_to cycle_counts_path, notice: t('.success')
    else
      redirect_to cycle_counts_path, alert: t('.failure')
    end
  end

  private

  def render_index
    render :index, locals: { cycle_counts: cycle_counts }
  end

  def render_show
    render :show, locals: { cycle_count: cycle_count }
  end

  def render_new
    render :new, locals: { resource: cycle_count }
  end

  def render_edit
    render :edit, locals: { resource: cycle_count }
  end

  def cycle_count_params
    return {} if params[:cycle_count].nil?

    params
      .require(:cycle_count)
      .permit(:location_id, :requested_date)
  end

  def cycle_count
    @cycle_count ||= params[:id] ? find_cycle_count : build_cycle_count
    @cycle_count.decorate
  end

  def cycle_counts
    @cycle_counts ||= CycleCount.all.page(params[:page])
    @cycle_counts = PaginatingDecorator.decorate(@cycle_counts)
  end

  def build_cycle_count
    CycleCount.new(cycle_count_params)
  end

  def find_cycle_count
    CycleCount.find(params[:id])
  end
end
