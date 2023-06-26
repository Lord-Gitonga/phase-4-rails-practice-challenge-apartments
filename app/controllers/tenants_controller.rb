class TenantsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
rescue_from ActiveRecord::RecordInvalid, with: :render_record_invalid_respone  
    
    
    def index
        tenants = Tenant.all
        render json: tenants
    end

    def show
        tenants = find_tenant
        render json: tenants
    end

    def update
        tenant = find_tenant
        tenant.update!(tenant_params)
        render json: tenants, status: :ok
    end

    private 

    def find_tenant
        Tenant.find(params[:id])
    end

    def tenant_params
        params.permit(:name, :age)
    end

    def render_not_found_response
        render json: {error: "Tenant not found"}, status: :not_found
    end

     def render_record_invalid_respone(invalid)
        render json: {error: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end
end
