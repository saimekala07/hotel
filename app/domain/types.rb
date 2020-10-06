require 'cgi'
require 'dry-types'

Dry::Types.load_extensions(:maybe)

module Types
  send(:include, Dry.Types())
  include Dry::Logic

  RoomNames = RoomType.all.map(&:name).uniq
  RoomKinds = Types::Coercible::String.enum(*RoomNames)
end