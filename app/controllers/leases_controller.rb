class LeasesController < ApplicationController
rescue_from ActiveRecord::RecordInvalid, with: :render_record_invalid_respone  
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response  
    def show 
        lease = find_lease
        render json: lease
    end

    def create
        lease = Lease.create(lease_params)
        render json: lease, status: :created
    end

    def destroy 
        lease = find_lease
        lease.destroy
    end

    private
    
    def find_lease
        Lease.find(params[:id])
    end

    def lease_params
        params.permit(:rent, :apartment_id, :tenant_id)
    end
    
    def render_not_found_response
        render json: {error: "Lease not found"}, status: :not_found
    end

    def render_record_invalid_respone(invalid)
        render json: {error: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end
end
