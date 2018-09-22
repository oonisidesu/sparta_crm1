class CustomersController < ApplicationController

  before_action :authenticate_user!
  before_action :set_customer, only: [:show, :edit, :update, :destroy] #追加

  def index
    @q = Customer.includes(:post, :company, :comments).ransack(params[:q])
    @customers = @q.result.page(params[:page]).per(10)
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)
    if  @customer.save
      redirect_to @customer
    else
      render :new
    end
  end

  def edit
    
  end

  def update
    
    if  @customer.update(customer_params)
      redirect_to @customer
    else
      render :edit
    end
  end

  def show
    @comment = @customer.comments.build
    @comments = Comment.where(customer_id: @customer.id)
  end

  def destroy
    
    @customer.destroy
    redirect_to customers_path
    
  end

  private

  def customer_params
    params.require(:customer).permit(
      :family_name,
      :given_name,
      :email,
      :company_id,
      :post_id
      )
  end

  def set_customer
    @customer = Customer.find(params[:id])
  end
end
