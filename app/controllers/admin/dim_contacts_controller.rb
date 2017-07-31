class Admin::DimContactsController < Admin::BaseController
  before_action :set_dim_contact, only: [:show, :edit, :update, :destroy]

  def index
    @dim_contacts = DimContact.all
  end

  def new
    @dim_contact = DimContact.new
  end

  def create
    @dim_contact = DimContact.new(dim_contact_params)
    respond_to do |format|
      if @dim_contact.save
        format.html { redirect_to admin_dim_contacts_path, notice: 'New record was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def edit
    # some code here
  end

  def update
    respond_to do |format|
      if @dim_contact.update(dim_contact_params)
        format.html { redirect_to admin_dim_contacts_path, notice: 'Record was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @dim_contact.destroy
    respond_to do |format|
      format.html { redirect_to admin_dim_contacts_url, notice: 'Record was successfully destroyed.' }
    end
  end

  def import
    @model = DimContact
  end

  def do_import
    DimContact.import(params[:file])
    # redirect_to admin_dim_contacts_url, notice: "New records successfully imported."
  end

  private
    def set_dim_contact
      @dim_contact = DimContact.find(params[:id])
    end
    def dim_contact_params
      params.require(:dim_contact).permit(:name, :file)
    end
end
