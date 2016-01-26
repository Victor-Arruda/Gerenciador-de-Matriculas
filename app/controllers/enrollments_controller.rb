class EnrollmentsController < ApplicationController
  before_action :set_enrollment, only: [:show, :edit, :update, :destroy]

  # GET /enrollments
  # GET /enrollments.json
  def index
    @enrollments = Enrollment.all
  end

  # GET /enrollments/1
  # GET /enrollments/1.json
  def show
  end

  # GET /enrollments/new
  def new
    @years = [['2010', 2010],['2011', 2011],['2012', 2012],['2013', 2013],['2014', 2014],['2015', 2015],['2016', 2016],['2017', 2018],['2019', 2019],['2020', 2020]]
    @enrollment = Enrollment.new
  end

  # GET /enrollments/1/edit
  def edit
  end

  def pay
    @enrollment = Enrollment.find(params[:enrollment_id])
    @enrollment.update_attribute(:paid, 1)
    redirect_to @enrollment, notice: 'Matricula paga!'
  end

  def deactivate
    @enrollment = Enrollment.find(params[:enrollment_id])
    @enrollment.update_attribute(:active, 2)
    redirect_to @enrollment, notice: 'Matrícula desativada!'
  end

  # GET /enrollments/1/pay_enrollment
  def pay_enrollment
    @enrollment = Enrollment.find(params[:id])
    @enrollment.update_attribute(:paid, params[:paid])
    #redirect_to @enrollment, notice: 'Matrícula paga com sucesso.'
  end

  # POST /enrollments
  # POST /enrollments.json
  def create
    @enrollment = Enrollment.new(enrollment_params)

    respond_to do |format|
      if @enrollment.save
        format.html { redirect_to @enrollment, notice: 'Enrollment was successfully created.' }
        format.json { render :show, status: :created, location: @enrollment }
      else
        format.html { render :new }
        format.json { render json: @enrollment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /enrollments/1
  # PATCH/PUT /enrollments/1.json
  def update
    respond_to do |format|
      if @enrollment.update(enrollment_params)
        format.html { redirect_to @enrollment, notice: 'Enrollment was successfully updated.' }
        format.json { render :show, status: :ok, location: @enrollment }
      else
        format.html { render :edit }
        format.json { render json: @enrollment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /enrollments/1
  # DELETE /enrollments/1.json
  def destroy
    @enrollment.destroy
    respond_to do |format|
      format.html { redirect_to enrollments_url, notice: 'Enrollment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_enrollment
      @enrollment = Enrollment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def enrollment_params
      params.require(:enrollment).permit(:enrollment_date, :year, :active, :paid, :student_id, :course_id)
    end
end
