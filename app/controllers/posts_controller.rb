class PostsController < ApplicationController
  before_action :allow_authorized_only, except: [:index, :show]
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # get /posts
  def index
    @posts = Post.order('id desc').page(params[:page] || 1).per(5)
  end

  # get /posts/new
  def new
    speech = Speech.new
    text   = []
    @post  = Post.new

    (rand(4) + 3).times { text << speech.passage }
    @post.title = speech.sentence
    @post.body  = text.join "\n\n"
  end

  # post /posts
  def create
    @post = Post.new post_parameters
    if @post.save
      flash[:notice] = t('post.created')
      redirect_to @post
    else
      render action: new
    end
  end

  # get /posts/:id
  def show
  end

  # get /posts/:id/edit
  def edit
  end

  # patch /posts/:id
  def update
    if @post.update post_parameters
      flash[:notice] = t('post.updated')
    else
      render action: :edit
    end
  end

  # delete /posts/:id
  def destroy
    if @post.destroy
      flash[:notice] = t('post.destroyed')
    end

    redirect_to posts_path
  end

  protected

  def post_parameters
    params.require(:post).permit(:title, :body)
  end

  def set_post
    @post = Post.find params[:id]
  end
end
