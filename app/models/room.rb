class Room
  include Mongoid::Document
  field :name, type: String
  field :session_Id, type: String
  field :public, type: Boolean
  field :timestamp, type: DateTime
  field :com
  field :info
end
