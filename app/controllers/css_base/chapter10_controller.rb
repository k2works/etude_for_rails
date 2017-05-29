class CssBase::Chapter10Controller < ApplicationController
  def sample_10_01
  end

  def sample_10_02
    render 'css_base/chapter10/sample_10_02/index'
  end

  def sample_10_02_point
    render 'css_base/chapter10/sample_10_02/point'
  end

  def sample_10_02_course
    render 'css_base/chapter10/sample_10_02/course'
  end

  def sample_10_02_trial
    render 'css_base/chapter10/sample_10_02/trial'
  end

  def sample_10_02_access
    render 'css_base/chapter10/sample_10_02/access'
  end

  def sample_10_02_contact
    render 'css_base/chapter10/sample_10_02/contact'
  end
end
