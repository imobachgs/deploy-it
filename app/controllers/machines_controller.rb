class MachinesController < ApplicationController

  def index
    # @machines = current_user.machines
    @machines = Machine.all
  end

  def show
    set_machine
  end

  def new
    @machine = Machine.new
  end

  def create
    @machine = Machine.new(machine_params)
    if @machine.save
      redirect_to machines_path
    else
      render :new
    end
  end

  def edit
    set_machine
  end

  def update
    set_machine
    if @machine.update_attributes(machine_params)
      redirect_to machines_path
    else
      render :edit
    end
  end

  def destroy
    set_machine
    @machine.destroy
    redirect_to machines_path
  end

  private

  def set_machine
    @machine = Machine.find(params[:id])
  end

  def machine_params
    params.require(:machine).permit(:name, :ip)
  end
end
