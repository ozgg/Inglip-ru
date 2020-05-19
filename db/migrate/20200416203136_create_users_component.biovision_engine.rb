# frozen_string_literal: true
# This migration comes from biovision_engine (originally 20200224000010)

# Create tables for Users component
class CreateUsersComponent < ActiveRecord::Migration[6.0]
  def up
    create_component
    create_users unless User.table_exists?
    create_tokens unless Token.table_exists?
    create_login_attempts unless LoginAttempt.table_exists?
    create_user_languages unless UserLanguage.table_exists?
    create_foreign_sites unless ForeignSite.table_exists?
    create_foreign_users unless ForeignUser.table_exists?
    create_component_links unless BiovisionComponentUser.table_exists?
    create_codes unless Code.table_exists?
    create_notifications unless Notification.table_exists?
  end

  def down
    drop_table :notifications if Notification.table_exists?
    drop_table :codes if Code.table_exists?
    drop_table :biovision_component_users if BiovisionComponentUser.table_exists?
    drop_table :foreign_users if ForeignUser.table_exists?
    drop_table :foreign_sites if ForeignSite.table_exists?
    drop_table :user_languages if UserLanguage.table_exists?
    drop_table :login_attempts if LoginAttempt.table_exists?
    drop_table :tokens if Token.table_exists?
    drop_table :users if User.table_exists?
    BiovisionComponent[Biovision::Components::UsersComponent.slug]&.destroy
  end

  private

  def create_component
    slug = Biovision::Components::UsersComponent.slug

    settings = {
      registration_open: true,
      email_as_login: false,
      confirm_email: false,
      require_email: false,
      invite_only: false,
      use_invites: false,
      invite_count: 5,
      bounce_count: 10,
      bounce_timeout: 15
    }

    BiovisionComponent.create(slug: slug, settings: settings)
  end

  def create_users
    create_table :users, comment: 'Users' do |t|
      t.uuid :uuid, null: false
      t.references :language, foreign_key: { on_update: :cascade, on_delete: :nullify }
      t.references :agent, foreign_key: { on_update: :cascade, on_delete: :nullify }
      t.references :ip_address, foreign_key: { on_update: :cascade, on_delete: :nullify }
      t.timestamps
      t.integer :primary_id, index: true
      t.integer :inviter_id, index: true
      t.integer :balance, default: 0, null: false
      t.boolean :super_user, default: false, null: false
      t.boolean :banned, default: false, null: false
      t.boolean :bot, default: false, null: false
      t.boolean :deleted, default: false, null: false
      t.boolean :consent, default: false, null: false
      t.boolean :email_confirmed, default: false, null: false
      t.boolean :phone_confirmed, default: false, null: false
      t.boolean :allow_mail, default: true, null: false
      t.datetime :last_seen
      t.date :birthday
      t.string :slug, null: false
      t.string :screen_name, null: false
      t.string :password_digest, null: false
      t.string :email, index: true
      t.string :phone, index: true
      t.string :image
      t.string :notice
      t.string :referral_link
      t.jsonb :data, default: { profile: {} }, null: false
    end

    add_foreign_key :users, :users, column: :inviter_id, on_update: :cascade, on_delete: :nullify
    add_foreign_key :users, :users, column: :primary_id, on_update: :cascade, on_delete: :nullify

    add_index :users, :uuid, unique: true
    add_index :users, :slug, unique: true
    add_index :users, :data, using: :gin
    add_index :users, :referral_link, unique: true
  end

  def create_tokens
    create_table :tokens, comment: 'Authentication tokens' do |t|
      t.references :user, null: false, foreign_key: { on_update: :cascade, on_delete: :cascade }
      t.references :agent, foreign_key: { on_update: :cascade, on_delete: :nullify }
      t.references :ip_address, foreign_key: { on_update: :cascade, on_delete: :nullify }
      t.timestamps
      t.datetime :last_used, index: true
      t.boolean :active, default: true, null: false
      t.string :token, null: false
    end

    add_index :tokens, :token, unique: true
  end

  def create_login_attempts
    create_table :login_attempts, comment: 'Failed login attempts' do |t|
      t.references :user, null: false, foreign_key: { on_update: :cascade, on_delete: :cascade }
      t.references :agent, foreign_key: { on_update: :cascade, on_delete: :nullify }
      t.references :ip_address, foreign_key: { on_update: :cascade, on_delete: :nullify }
      t.timestamps
      t.string :password, default: '', null: false
    end
  end

  def create_user_languages
    create_table :user_languages, comment: 'Languages for users' do |t|
      t.references :user, null: false, foreign_key: { on_update: :cascade, on_delete: :cascade }
      t.references :language, null: false, foreign_key: { on_update: :cascade, on_delete: :cascade }
      t.timestamps
    end
  end

  def create_foreign_sites
    create_table :foreign_sites, comment: 'Sites for external authentication' do |t|
      t.string :slug, null: false
      t.string :name, null: false
      t.integer :foreign_users_count, default: 0, null: false
    end

    add_index :foreign_sites, :slug, unique: true
  end

  def create_foreign_users
    create_table :foreign_users, comment: 'Users from external sites' do |t|
      t.references :foreign_site, null: false, foreign_key: { on_update: :cascade, on_delete: :cascade }
      t.references :user, null: false, foreign_key: { on_update: :cascade, on_delete: :cascade }
      t.references :agent, foreign_key: { on_update: :cascade, on_delete: :nullify }
      t.references :ip_address, foreign_key: { on_update: :cascade, on_delete: :nullify }
      t.string :slug, null: false
      t.timestamps
      t.jsonb :data, default: {}, null: false
    end

    add_index :foreign_users, :data, using: :gin
  end

  def create_component_links
    create_table :biovision_component_users, comment: 'Privileges and settings for users in components' do |t|
      t.references :biovision_component, null: false, foreign_key: { on_update: :cascade, on_delete: :cascade }
      t.references :user, null: false, foreign_key: { on_update: :cascade, on_delete: :cascade }
      t.boolean :administrator, default: false, null: false
      t.timestamps
      t.jsonb :data, default: {}, null: false
    end

    add_index :biovision_component_users, :data, using: :gin
  end

  def create_codes
    create_table :codes, comment: 'Codes for different purposes' do |t|
      t.references :biovision_component, null: false, foreign_key: { on_update: :cascade, on_delete: :cascade }
      t.references :user, null: false, foreign_key: { on_update: :cascade, on_delete: :cascade }
      t.references :agent, foreign_key: { on_update: :cascade, on_delete: :nullify }
      t.references :ip_address, foreign_key: { on_update: :cascade, on_delete: :nullify }
      t.integer :quantity, default: 1, null: false
      t.string :body, null: false
      t.timestamps
      t.jsonb :data, default: {}, null: false
    end

    add_index :codes, :body, unique: true
    add_index :codes, :data, using: :gin
  end

  def create_notifications
    create_table :notifications, comment: 'Component notifications for users' do |t|
      t.uuid :uuid, null: false
      t.references :biovision_component, null: false, foreign_key: { on_update: :cascade, on_delete: :cascade }
      t.references :user, null: false, foreign_key: { on_update: :cascade, on_delete: :cascade }
      t.boolean :email_sent, default: false, null: false
      t.boolean :read, default: false, null: false
      t.timestamps
      t.jsonb :data, default: {}, null: false
    end

    add_index :notifications, :uuid, unique: true
    add_index :notifications, :data, using: :gin
  end
end
