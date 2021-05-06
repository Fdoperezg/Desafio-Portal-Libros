class OrdersController < ApplicationController
    before_action :authenticate_user!
    def index
      @orders = Order.where(user_id: current_user.id, paid: false)
    end
    def create
      book = Book.find(params[:book_id])
      order = Order.find_or_create_by(user_id: current_user.id, book_id: book.id, paid: false)
      order.quantity += 1
      if order.save 
        redirect_to root_path, notice: 'Se ha reservado el libro'
      else 
        redirect_to root_path, alert: 'No se ha podido reservar el libro'
    end  
    end
    def destroy
      order = Order.find(params[:id])
      order.destroy 
      redirect_to orders_path, notice: 'Se ha quitado el libro de las reservas'
    end
    def clean
      order = Order.where(paid: false)
      order.destroy_all
      redirect_to orders_path, notice: 'Ya no tienes ningún libro reservado'
    end
    
  end  