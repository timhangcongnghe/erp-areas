module Erp
  module Areas
    module Backend
      class DistrictsController < Erp::Backend::BackendController
        before_action :set_district, only: [:archive, :unarchive, :edit, :update, :destroy]
        before_action :set_districts, only: [:delete_all, :archive_all, :unarchive_all]
        
        # GET /districts
        def index
        end
        
        # POST /districts/list
        def list
          @districts = District.all
          
          render layout: nil
        end
    
        # GET /districts/new
        def new
          @district = District.new
        end
    
        # GET /districts/1/edit
        def edit
        end
    
        # POST /districts
        def create
          @district = District.new(district_params)
    
          if @district.save
            if request.xhr?
              render json: {
                status: 'success',
                text: @district.name,
                value: @district.id
              }
            else
              redirect_to erp_areas.edit_backend_district_path(@district), notice: t('.success')
            end
          else
            if request.xhr?
              render '_form', layout: nil, locals: {district: @district}
            else
              render :new
            end            
          end
        end
    
        # PATCH/PUT /districts/1
        def update
          if @district.update(district_params)
            if request.xhr?
              render json: {
                status: 'success',
                text: @district.name,
                value: @district.id
              }
            else
              redirect_to erp_areas.edit_backend_district_path(@district), notice: t('.success')
            end            
          else
            render :edit
          end
        end
    
        # DELETE /districts/1
        def destroy
          @district.destroy
          
          respond_to do |format|
            format.html { redirect_to erp_areas.backend_districts_path, notice: t('.success') }
            format.json {
              render json: {
                'message': t('.success'),
                'type': 'success'
              }
            }
          end 
        end
        
        # ARCHIVE /districts/archive?id=1
        def archive      
          @district.archive
          
          respond_to do |format|
            format.json {
              render json: {
                'message': t('.success'),
                'type': 'success'
              }
            }
          end          
        end
        
        # UNARCHIVE /districts/unarchive?id=1
        def unarchive
          @district.unarchive
          
          respond_to do |format|
            format.json {
              render json: {
                'message': t('.success'),
                'type': 'success'
              }
            }
          end          
        end
        
        # DELETE /districts/delete_all?ids=1,2,3
        def delete_all         
          @districts.destroy_all
          
          respond_to do |format|
            format.json {
              render json: {
                'message': t('.success'),
                'type': 'success'
              }
            }
          end          
        end
        
        # ARCHIVE ALL /districts/archive_all?ids=1,2,3
        def archive_all         
          @districts.archive_all
          
          respond_to do |format|
            format.json {
              render json: {
                'message': t('.success'),
                'type': 'success'
              }
            }
          end          
        end
        
        # UNARCHIVE ALL /districts/unarchive_all?ids=1,2,3
        def unarchive_all
          @districts.unarchive_all
          
          respond_to do |format|
            format.json {
              render json: {
                'message': t('.success'),
                'type': 'success'
              }
            }
          end          
        end
        
        # DATASELECT
        def dataselect
          respond_to do |format|
            format.json {
              render json: District.dataselect(params[:keyword], params)
            }
          end
        end
    
        private
          # Use callbacks to share common setup or constraints between actions.
          def set_district
            @district = District.find(params[:id])
          end
          
          def set_districts
            @districts = District.where(id: params[:ids])
          end
    
          # Only allow a trusted parameter "white list" through.
          def district_params
            params.fetch(:district, {}).permit(:name, :state_id)
          end
      end
    end
  end
end
