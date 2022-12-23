class InstructorsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :instructor_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :instructor_not_created_response

    def index
        instructors = Instructor.all
        render json: instructors, status: :ok
    end

    def show
        instructor = Instructor.find_by!(id: params[:id])
        render json: instructor, status: :ok
    end

    def create
        new_instructor = Instructor.create!(instructor_params)
        render json: new_instructor, status: :created
    end

    def update
        instructor = Instructor.find_by!(id: params[:id])
        instructor.update!(instructor_params)
        render json: instructor, status: :accepted
    end

    def destroy
        instructor = Instructor.find_by!(id: params[:id])
    end

    private

    def instructor_params
        params.permit(:name)
    end

    def instructor_not_found_response
        render json: {error: "Instructor not found"}, status: :not_found
    end

    def instructor_not_created_response
        render json: {errors: ['validation errors']}, status: :unprocessable_entity
    end
end
