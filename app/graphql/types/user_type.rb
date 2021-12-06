module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :username, String, null: false
    field :moods, [Types::MoodType], null: true
    field :journal_entries, [Types::JournalEntryType]
    field :journals, [Types::JournalType]
    field :habit_entries, [Types::HabitEntryType]
    field :habits, [Types::HabitType]
    field :weekly_habits, [Types::HabitEntryType]
    field :weekly_moods, [Types::MoodType], null: true
    field :daily_mood, Types::MoodType, null: true
    field :daily_habits, [Types::HabitType], null: true
    field :monthly_moods, [Types::MoodType], null: true do
      argument :month, Int, required: false, default_value: Date.today.month
    end

    def weekly_moods
      object.weekly_moods
    end

    def monthly_moods(month:)
      object.moods.monthly_moods(month)
    end

    def journals
      object.journals.distinct
    end

    def habits
      Habit.all
    end

    def weekly_habits
      object.weekly_habits
    end

    def journal_entries
      object.journal_entries.weekly_journal
    end

    def daily_mood
      object.daily_mood
    end

    def daily_habits
      Habit.find(object.habit_entries.daily_completed)
    end
  end
end
