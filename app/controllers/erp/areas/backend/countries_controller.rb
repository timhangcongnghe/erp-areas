require_dependency "erp/application_controller"

module Erp
  module Areas
    module Backend
      class CountriesController < Erp::Backend::BackendController
        before_action :set_country, only: [:edit, :update, :destroy]
        before_action :set_countries, only: [:delete_all, :archive_all, :unarchive_all]
    
        # GET /countries
        def index
        end
    
        # GET /countries/1
        #def show
        #end
        
        # POST /contacts/list
        def list
          @countries = Country.search(params).paginate(:page => params[:page], :per_page => 5)
          
          render layout: nil
        end
    
        # GET /countries/new
        def new
          @country = Country.new
        end
    
        # GET /countries/1/edit
        def edit
        end
    
        # POST /countries
        def create
          @country = Country.new(country_params)
    
          if @country.save
            if request.xhr?
              render json: {
                status: 'success',
                text: @country.name,
                value: @country.id
              }
            else
              redirect_to erp_areas.edit_backend_country_path(@country), notice: t('.success')
            end
          else
            if params.to_unsafe_hash['format'] == 'json'
              render '_form', layout: nil, locals: {country: @country}
            else
              render :new
            end            
          end
        end
    
        # PATCH/PUT /countries/1
        def update
          if @country.update(country_params)
            if request.xhr?
              render json: {
                status: 'success',
                text: @country.name,
                value: @country.id
              }
            else
              redirect_to erp_areas.edit_backend_country_path(@country), notice: t('.success')
            end
          else
            render :edit
          end
        end
    
        # DELETE /countries/1
        def destroy
          @country.destroy
          redirect_to erp_areas.backend_countries_path, notice: t('.success')
        end
        
        # DELETE /countries/delete_all?ids=1,2,3
        def delete_all         
          @countries.destroy_all
          
          respond_to do |format|
            format.json {
              render json: {
                'message': t('.success'),
                'type': 'success'
              }
            }
          end          
        end
        
        # Archive /countries/archive_all?ids=1,2,3
        def archive_all         
          @countries.archive_all
          
          respond_to do |format|
            format.json {
              render json: {
                'message': t('.success'),
                'type': 'success'
              }
            }
          end          
        end
        
        # Unarchive /countries/unarchive_all?ids=1,2,3
        def unarchive_all
          @countries.unarchive_all
          
          respond_to do |format|
            format.json {
              render json: {
                'message': t('.success'),
                'type': 'success'
              }
            }
          end          
        end
        
        def dataselect
          respond_to do |format|
            format.json {
              render json: Country.dataselect(params[:keyword])
            }
          end
        end
    
        private
          # Use callbacks to share common setup or constraints between actions.
          def set_country
            @country = Country.find(params[:id])
          end
          
          def set_countries
            @countries = Country.where(id: params[:ids])
          end
    
          # Only allow a trusted parameter "white list" through.
          def country_params
            params.fetch(:country, {}).permit(:name, :code)
          end
      end
    end
  end
end
