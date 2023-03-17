class User < ApplicationRecord
  has_many :active_conversations, foreign_key: 'sender_id', class_name: 'Conversation', dependent: :destroy
  has_many :passive_conversations, foreign_key: 'recipient_id', class_name: 'Conversation', dependent: :destroy
  has_many :sending, through: :active_conversations, source: :recipient
  has_many :receiving, through: :passive_relationships, source: :sender
end