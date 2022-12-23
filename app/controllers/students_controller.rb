class StudentsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :student_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :student_not_created_response

    def index
        students = Student.all
        render json: students, status: :ok
    end

    def show
        student = Student.find_by!(id: params[:id])
        render json: student, status: :ok
    end

    def create
        new_student = Student.create!(student_params)
        render json: new_student, status: :created
    end

    def update
        student = Student.find_by!(id: params[:id])
        student.update!(student_params)
        render json: student, status: :accepted
    end

    def destroy
        student = Student.find_by!(id: params[:id])
        student.destroy

        head :no_content
    end
    
    private

    def student_params
        params.permit(:name, :major, :age, :instructor_id)
    end

    def student_not_found_response
        render json: {error: 'Student not found'}, status: :not_found
    end

    def student_not_created_response
        render json: {errors: ['validation errors']}, status: :unprocessable_entity
    end
end
