class BlogsController < ApplicationController

  def index
    #@blogs = Blog.includes(:user).order("created_at DESC")
    @username = current_user.username  if user_signed_in?
    @search = Blog.search(params[:q])
    @blogs = @search.result.includes(:user).order("created_at DESC")
    #binding.pry
  end

  def new
    @username = current_user.username  if user_signed_in?
    @blog = Blog.new
  end

  def create
    Blog.create(blog_params)
    @username = current_user.username  if user_signed_in?
  end

  def destroy
    blog = Blog.find(params[:id])
    blog.destroy if blog.user_id == current_user.id
    @username = current_user.username  if user_signed_in?
  end

  def edit
    @blog = Blog.find(params[:id])
    @username = current_user.username  if user_signed_in?
  end

  def update
    blog = Blog.find(params[:id])
    blog.update(blog_params)  if blog.user_id == current_user.id
    @username = current_user.username  if user_signed_in?
  end

  def random

    blogs = Blog.all
    max_id = 0

    blogs.each do |blog| #ブログの中で一番大きいidを検出する
      max_id = blog.id  if max_id < blog.id
    end

    while true do
      blog_random_pickup = rand(max_id) + 1
      if Blog.exists?(id:blog_random_pickup) #ランダムに選んだidのレコードが存在するか確かめる
        random_blog_numder = blog_random_pickup
        break
      end
    end

    @blog = Blog.find(random_blog_numder)

    @username = current_user.username  if user_signed_in?
  end

  private
  def blog_params
    params.permit(:title, :text).merge(user_id: current_user.id)
  end

end
