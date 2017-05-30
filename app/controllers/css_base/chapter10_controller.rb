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

  def sample_10_03
    render 'css_base/chapter10/sample_10_03/index'
  end

  def sample_10_03_about
    render 'css_base/chapter10/sample_10_03/about/index'
  end

  def sample_10_03_service
    page = params[:page]
    if page == 'company'
      render 'css_base/chapter10/sample_10_03/service/company/index'
    elsif page == 'personal'
      render 'css_base/chapter10/sample_10_03/service/personal/index'
    else
      render 'css_base/chapter10/sample_10_03/service/index'
    end
  end

  def sample_10_03_contact
    render 'css_base/chapter10/sample_10_03/contact/index'
  end

  def sample_10_03_blog
    render 'css_base/chapter10/sample_10_03/blog/index'
  end
end
