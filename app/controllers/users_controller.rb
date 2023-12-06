# app/controllers/users_controller.rb

class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    
    # Set up initial conditions after signing up
    @user.quarters = 3
    @user.white_dice = 3
    @user.points = 0

    if @user.save
      # Your successful signup logic here
      redirect_to root_path, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    # You can add logic here if needed

    # Render the "User" page
  end

  def play_game
    # Load game settings from the form or initialize with defaults
    @num_players = params[:num_players].to_i
    @num_die_sides = params[:num_die_sides].to_i
    @num_dice = params[:num_dice].to_i

    # Validate that the required parameters are present
    if @num_players <= 0 || @num_die_sides <= 0 || @num_dice <= 0
      flash.now[:alert] = 'Please provide valid game settings.'
      render :new
      return
    end

    # Run the AutoDropDead game with the provided settings
    auto_drop_dead = AutoDropDead::AutoDropDead.new(@num_players)
    auto_drop_dead.play_game(@num_die_sides, @num_dice, @num_players)

    # [Optional] Store the game alongside the date and time the game was run
    Game.create(transcript: auto_drop_dead.transcript.join("\n"))

    # Display the game to the user
    render :play_game, locals: { transcript: auto_drop_dead.transcript }
  end

  def display_game
    # This action will render the game display page
    # You can retrieve the game data and display it here
    # Consider storing game data in an instance variable like @game_data
    :display_game
  end

  def game_history
    # Add any logic needed for displaying game history
    # Render the "Game History" page
    render :game_history
  end

  def exit_game
    # Add any cleanup or logout logic if needed
    # Redirect to the "Sign-In" page
    redirect_to sign_in_path
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
