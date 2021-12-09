require 'rails_helper'

RSpec.describe JournalEntry, type: :model do
  describe 'relationships' do
    it { should belong_to :user }
    it { should belong_to :journal }
  end
  describe 'scopes' do

    let!(:user) { create :user }
    let!(:journal) { create :journal}
    let!(:journal_entry) { create_list :journal_entry, 7, user_id: user.id, journal_id: journal.id }
    let!(:past_journal_entries) { create_list :journal_entry, 5, created_at: Date.today - 8, user_id: user.id, journal_id: journal.id }

    it 'returns last 7 journal entries' do
      expect(user.journal_entries.weekly_journal).to eq(journal_entry.reverse)
    end

    it 'creates new journal entries' do
      JournalEntry.create!(content: 'something', user_id: user.id, journal_id: journal.id)
      expect(journal.journal_entries.count).to eq(13)
    end
  end
end
