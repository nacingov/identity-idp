module Idv
  class VendorResult
    attr_reader :success, :errors, :reasons, :session_id, :normalized_applicant, :timed_out

    def self.new_from_json(json)
      parsed = JSON.parse(json, symbolize_names: true)

      applicant = parsed[:normalized_applicant]
      parsed[:normalized_applicant] = Proofer::Applicant.new(applicant) if applicant

      new(**parsed)
    end

    def initialize(success: nil, errors: {}, reasons: [], session_id: nil,
                   normalized_applicant: nil, timed_out: nil)
      @success = success
      @errors = errors
      @reasons = reasons
      @session_id = session_id
      @normalized_applicant = normalized_applicant
      @timed_out = timed_out
    end

    def success?
      success
    end

    def timed_out?
      timed_out
    end

    def job_failed?
      errors.fetch(:job_failed, false)
    end
  end
end
