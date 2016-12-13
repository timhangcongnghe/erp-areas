require_dependency "erp/application_controller"

module Erp
  module Areas
    module Backend
      class StatesController < Erp::Backend::BackendController
        before_action :set_state, only: [:edit, :update, :destroy]
        before_action :set_states, only: [:delete_all, :archive_all, :unarchive_all]
        
        # GET /states
        def index
        end
    
        # GET /states/1
        #def show
        #end
        
        # POST /states/list
        def list
          @states = State.search(params).paginate(:page => params[:page], :per_page => 5)
          
          render layout: nil
        end
    
        # GET /states/new
        def new
          @state = State.new
        end
    
        # GET /states/1/edit
        def edit
        end
    
        # POST /states
        def create
          @state = State.new(state_params)
    
          if @state.save
            if params.to_unsafe_hash['format'] == 'json'
              render json: {
                status: 'success',
                text: @state.name,
                value: @state.id
              }
            else
              redirect_to erp_areas.edit_backend_state_path(@state), notice: 'State was successfully created.'
            end
          else
            if params.to_unsafe_hash['format'] == 'json'
              render '_form', layout: nil, locals: {state: @state}
            else
              render :new
            end            
          end
        end
    
        # PATCH/PUT /states/1
        def update
          if @state.update(state_params)
            redirect_to erp_areas.edit_backend_state_path(@state), notice: 'State was successfully updated.'
          else
            render :edit
          end
        end
    
        # DELETE /states/1
        def destroy
          @state.destroy
          redirect_to erp_areas.backend_states_path, notice: 'State was successfully destroyed.'
        end
        
        # DELETE /states/delete_all?ids=1,2,3
        def delete_all         
          @states.destroy_all
          
          respond_to do |format|
            format.json {
              render json: {
                'message': 'States were successfully destroyed.',
                'type': 'success'
              }
            }
          end          
        end
        
        # Archive /states/archive_all?ids=1,2,3
        def archive_all         
          @states.archive_all
          
          respond_to do |format|
            format.json {
              render json: {
                'message': 'States were successfully archived.',
                'type': 'success'
              }
            }
          end          
        end
        
        # Unarchive /states/unarchive_all?ids=1,2,3
        def unarchive_all
          @states.unarchive_all
          
          respond_to do |format|
            format.json {
              render json: {
                'message': 'States were successfully active.',
                'type': 'success'
              }
            }
          end          
        end
        
        def dataselect
          respond_to do |format|
            format.json {
              render json: State.dataselect(params[:keyword])
            }
          end
        end
    
        private
          # Use callbacks to share common setup or constraints between actions.
          def set_state
            @state = State.find(params[:id])
          end
          
          def set_states
            @states = State.where(id: params[:ids])
          end
    
          # Only allow a trusted parameter "white list" through.
          def state_params
            params.fetch(:state, {}).permit(:name, :code, :country_id)
          end
      end
    end
  end
end
