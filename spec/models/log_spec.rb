require 'rails_helper'

RSpec.describe Log, type: :model do
  # For test purposes, it does not matter what is the data stores in logs. So
  # these variables created in 'let' can be passed in the methods paramenters.
  let(:str_data) { "Data to save in log" }
  let(:hash_data) { { data: "to save in log" } }

  describe "Validations ->" do
    let(:log) { build(:log) }

    it "is valid with valid attributes" do
      expect(log).to be_valid
    end
  end

  describe ".log_message_sent" do
    subject { Log.log_message_sent(str_data, str_data) }

    it "creates the log" do
      expect{ subject }.to change{ Log.count }.by(1)
    end
  end

  describe ".log_message_sent_with_recommendation" do
    subject { Log.log_message_sent_with_recommendation(str_data, str_data) }

    it "creates the log" do
      expect{ subject }.to change{ Log.count }.by(1)
    end
  end

  describe ".log_recommendation_click" do
    subject { Log.log_recommendation_click(str_data, hash_data) }

    it "creates the log" do
      expect{ subject }.to change{ Log.count }.by(1)
    end
  end

  describe ".log_message_view" do
    subject { Log.log_message_view(str_data, str_data) }

    it "creates the log" do
      expect{ subject }.to change{ Log.count }.by(1)
    end
  end

  describe ".log_answer_view_simple" do
    subject { Log.log_answer_view_simple(str_data, str_data) }

    it "creates the log" do
      expect{ subject }.to change{ Log.count }.by(1)
    end
  end

  describe ".log_answer_view" do
    subject { Log.log_answer_view(str_data, str_data) }

    it "creates the log" do
      expect{ subject }.to change{ Log.count }.by(1)
    end
  end

  describe ".log_answer_try_again_click" do
    subject { Log.log_answer_try_again_click(str_data, str_data) }

    it "creates the log" do
      expect{ subject }.to change{ Log.count }.by(1)
    end
  end

  describe ".log_connection_view_simple" do
    subject { Log.log_connection_view_simple(str_data, str_data) }

    it "creates the log" do
      expect{ subject }.to change{ Log.count }.by(1)
    end
  end

  describe ".log_connection_create" do
    subject { Log.log_connection_create(str_data, str_data) }

    it "creates the log" do
      expect{ subject }.to change{ Log.count }.by(1)
    end
  end

  describe ".log_connection_accept" do
    subject { Log.log_connection_accept(str_data, str_data) }

    it "creates the log" do
      expect{ subject }.to change{ Log.count }.by(1)
    end
  end

  describe ".log_connection_reject" do
    subject { Log.log_connection_reject(str_data, hash_data) }

    it "creates the log" do
      expect{ subject }.to change{ Log.count }.by(1)
    end
  end

  describe ".log_search_simple" do
    subject { Log.log_search_simple(str_data, hash_data) }

    it "creates the log" do
      expect{ subject }.to change{ Log.count }.by(1)
    end
  end

  describe ".log_search_timeline" do
    subject { Log.log_search_timeline(str_data, hash_data) }

    it "creates the log" do
      expect{ subject }.to change{ Log.count }.by(1)
    end
  end

  describe ".log_search_tag" do
    subject { Log.log_search_tag(str_data, hash_data) }

    it "creates the log" do
      expect{ subject }.to change{ Log.count }.by(1)
    end
  end

  describe ".log_search_graph" do
    subject { Log.log_search_graph(str_data, hash_data) }

    it "creates the log" do
      expect{ subject }.to change{ Log.count }.by(1)
    end
  end

  describe ".log_add_tag" do
    subject { Log.log_add_tag(str_data, str_data, str_data) }

    it "creates the log" do
      expect{ subject }.to change{ Log.count }.by(1)
    end
  end

  describe ".log_accept_tag" do
    subject { Log.log_accept_tag(str_data, str_data, str_data) }

    it "creates the log" do
      expect{ subject }.to change{ Log.count }.by(1)
    end
  end

  describe ".log_remove_tag" do
    subject { Log.log_remove_tag(str_data, str_data, str_data) }

    it "creates the log" do
      expect{ subject }.to change{ Log.count }.by(1)
    end
  end

  describe ".log_reject_tag" do
    subject { Log.log_reject_tag(str_data, str_data, str_data) }

    it "creates the log" do
      expect{ subject }.to change{ Log.count }.by(1)
    end
  end

  describe ".log_graph_view" do
    subject { Log.log_graph_view(str_data) }

    it "creates the log" do
      expect{ subject }.to change{ Log.count }.by(1)
    end
  end

  describe ".log_graph_add_similar" do
    subject { Log.log_graph_add_similar(str_data, str_data) }

    it "creates the log" do
      expect{ subject }.to change{ Log.count }.by(1)
    end
  end

  describe ".log_graph_add_connected_component" do
    subject { Log.log_graph_add_connected_component(str_data, str_data) }

    it "creates the log" do
      expect{ subject }.to change{ Log.count }.by(1)
    end
  end

  describe ".log_graph_add" do
    subject { Log.log_graph_add(str_data, str_data) }

    it "creates the log" do
      expect{ subject }.to change{ Log.count }.by(1)
    end
  end

  describe ".log_graph_add_group" do
    subject { Log.log_graph_add_group(str_data, hash_data) }

    it "creates the log" do
      expect{ subject }.to change{ Log.count }.by(1)
    end
  end

  describe ".log_team_view" do
    subject { Log.log_team_view(str_data, str_data) }

    it "creates the log" do
      expect{ subject }.to change{ Log.count }.by(1)
    end
  end

  describe ".log_team_user_view" do
    subject { Log.log_team_user_view(str_data, str_data, str_data) }

    it "creates the log" do
      expect{ subject }.to change{ Log.count }.by(1)
    end
  end

  describe ".log_team_user_lo_view" do
    subject { Log.log_team_user_lo_view(str_data, str_data, str_data, str_data) }

    it "creates the log" do
      expect{ subject }.to change{ Log.count }.by(1)
    end
  end

  describe ".log_team_user_lo_question_view" do
    subject { Log.log_team_user_lo_question_view(str_data, str_data, str_data, str_data, str_data) }

    it "creates the log" do
      expect{ subject }.to change{ Log.count }.by(1)
    end
  end

  describe ".log_team_lo_overview_view" do
    subject { Log.log_team_lo_overview_view(str_data, str_data, str_data) }

    it "creates the log" do
      expect{ subject }.to change{ Log.count }.by(1)
    end
  end
end
