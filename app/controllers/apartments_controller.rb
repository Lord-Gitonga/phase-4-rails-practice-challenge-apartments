class ApartmentsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :response_not_found
rescue_from ActiveRecord::RecordInvalid, with: :render_record_invalid_respone  

    def index
        apartments = Apartment.all
        render json:apartments
    end

    def show
        apartments = find_apartment
        render json:apartments
    end

    def update 
        apartment = find_apartment
        apartment.update!(apartment_params)
        render json:apartment
    end

    def destroy 
        apartment = find_apartment
        apartment.destroy
    end

    private
    def find_apartment
        Apartment.find(params[:id])
    end

    def apartment_params
        params.permit(:number)
    end

    def response_not_found
        render json: {error: 'Not Found'}, status: :not_found
    end

    def render_record_invalid_respone(invalid)
        render json: {error: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end
end
