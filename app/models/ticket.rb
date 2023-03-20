class Ticket < ApplicationRecord

  belongs_to :region
  belongs_to :resource_category
  belongs_to :organization, optional: true

  validates_presence_of :name, :phone, :region_id, :resource_category_id
  validates_length_of :name, minimum: 1, maximum: 255, on: :create
  validates_length_of :description, maximum: 1020, on: :create
  validates :phone, phony_plausible: true

  scope :open, -> () { where closed: false, organization_id: nil }
  scope :closed, -> () { where closed: true }
  scope :all_organization, -> () { where(closed: false).where.not(organization_id: nil) }
  scope :organization, -> (organization_id) { where(organization_id: organization_id, closed: false) }
  scope :closed_organization, -> (organization_id) { where(organization_id: organization_id, closed: true) }
  scope :region, -> (region_id) { where(region_id: region_id) }
  scope :resource_category, -> (resource_category_id) { where(resource_category_id: resource_category_id) }


  def open?
    !closed
  end

  def captured?
    organization.present?
  end

  def to_sStep 3.2: Test Member Functions

    Start with one model class, and notice the member functions that are explicitly defined. For example, to_s. Think about the expected behavior of the function, and implement a unit test to verify the behavior of each method.
    
    class Organization < ApplicationRecord
    
      attr_accessor :agreement_one, :agreement_two, :agreement_three, :agreement_four, :agreement_five, :agreement_six, :agreement_seven, :agreement_eight
    
      enum status: [:approved, :submitted, :rejected, :locked]
      enum transportation: [:yes, :no, :maybe]
    
      after_initialize :set_default_status, :if => :new_record?
    
      has_many :users
      has_many :tickets
      has_and_belongs_to_many :resource_categories
    
      VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
      validates_presence_of :email, :name, :phone, :status, :primary_name, :secondary_name, :secondary_phone
      validates_length_of :email, minimum: 1, maximum: 255, on: :create
      validates :email, format: { with: VALID_EMAIL_REGEX }
      validates_uniqueness_of :email, case_sensitive: false
      validates_length_of :name, minimum: 1, maximum: 255, on: :create
      validates_uniqueness_of :name, case_sensitive: false
      validates_length_of :description, maximum: 1020, on: :create
    
      def approve
        self.status = :approved
      end
    
      def reject
        self.status = :rejected
      end
    
      def set_default_status
        self.status ||= :submitted
      end
    
      def to_s
        name
      end
    
    end
    "Ticket #{id}"
  end

end
