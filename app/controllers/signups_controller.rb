class SignupsController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    def create
        signup = Signup.create(time: params[:time], camper_id: params[:camper_id], activity_id: params[:activity_id])        

        if signup.valid?
            activity = Activity.find(params[:activity_id])
            render json: activity
        else 
            render json: { "errors": ["validation errors"] }
        end
    end
    
    private
    def render_unprocessable_entity_response(invalid)
        render json: { errors: "validation errors"}, status: :unprocessable_entity
    end
end
