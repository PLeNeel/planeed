class WithdrawsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def new
    @withdraw = Withdraw.new
  end

  def create
    @toxic = Toxic.find(params[:toxic_id])
    if params[:operator].present? # on vient du bouton
      @operator = params[:operator]
      brand_new_minus_action(@operator, @toxic)
    else # on vient du scan
      @withdraw = Withdraw.create(toxic: @toxic, user: current_user)
      toxic_ct = @toxic.current_quantity - 1
      @toxic.update(current_quantity: toxic_ct)
      flash[:notice] = "Le toxique \'#{@toxic.name}\' a bien été retiré"
      redirect_to new_scan_path
    end
  end

  private

  def brand_new_minus_action(operator, toxic)
    add_or_withdraw_toxics(operator, toxic)
    @withdraw = Withdraw.new(withdraw_params)
    @withdraw.user = current_user
    @withdraw.toxic = @toxic
    @withdraw.save
    respond_to do |format|
      format.html
      format.text
      format.json { render partial: "toxics/toxics_btn", locals: {toxic: @toxic, last_withdraw_id: @last_withdraw_id}, formats: [:html] }
    end
  end

  # def update_action(operator, toxic)
  #   add_or_withdraw_toxics(operator, toxic)
  #   @withdraw = toxic.withdraws.last
  #   new_quantity = add_or_withdraw(operator, toxic)
  #   @withdraw.update(quantity: new_quantity)
  #   respond_to do |format|
  #     format.html
  #     format.text
  #     format.json { render partial: "toxics/toxics_btn", locals: {toxic: @toxic}, formats: [:html] }
  #   end
  # end

  # def add_or_withdraw(operator, toxic)
  #   @withdraw = toxic.withdraws.last
  #   new_quantity = @withdraw.quantity
  #   if operator == "minus"
  #     new_quantity += 1
  #   else
  #     new_quantity -= 1
  #   end
  #   new_quantity
  # end

  def add_or_withdraw_toxics(operator, toxic)
    new_quantity = toxic.current_quantity
    if operator == "minus"
      new_quantity -= 1
    else
      new_quantity += 1
    end
    toxic.update!(current_quantity: new_quantity)
  end

  def withdraw_params
    params.require(:withdraw).permit(:toxic_id)
  end
end
