# -*- encoding : utf-8 -*-
require 'integration/integration_test_helper'

class FindADealerTest < IntegrationTest
  def setup
    super
    use_javascript
  end

  def teardown
    super
    WebMock.reset!
  end

  def test_find_a_dealer_near_glasgow_from_find_a_dealer_page_shows_dealer_stock
    VCR.use_cassette 'branch_manager_find_a_dealer_near_glasgow', match_requests_on: [:method, :uri, :body], allow_playback_repeats: true do
      on_find_a_dealer_page
      find_dealers_near 'Glasgow', franchise: 'Vauxhall'

      assert on_find_a_dealer_page?
      assert_equal 24, number_of_branches_shown
      assert branch_filter_shows location: 'Glasgow', franchise: 'Vauxhall'

      selected_branch = branch_name
      select_first_branch
      assert_selector branch_image

      click_link 'View dealer stock'
      assert_equal [selected_branch], vehicle_branch_names.uniq
      open_search_filters
      assert branch_checkbox.selected?
      close_search_filters

      select 'Mileage', from: 'sort-order'
      only_show_used_cars
      assert in_ascending_order mileages
    end
  end

  private

  def in_ascending_order items
    items.sort == items
  end

  def mileages
    all('.mileage').map { |li| li.text.gsub('Mileage ', '').delete(',').to_i }
  end

  def only_show_used_cars
    open_search_filters
    select('Used cars', from: 'search_type')
    close_search_filters
    wait_for_results
  end

  def select_first_branch
    # Capybara insists on clicking at 0, 0 coordinates, which are overflow: hidden
    page.execute_script "document.querySelector('.ac-card__block-link').click();"
  end

  def branch_name
    first('.ac-branch__name').text
  end

  def branch_image
    '.ac-branch__image-wrapper'
  end

  def branch_checkbox
    first('input#branch_id')
  end

  def vehicle_branch_names
    all('.ac-branchname').map(&:text)
  end

  def branch_filter_shows location:, franchise:
    value_of('#branch-location') == location && text_of('#franchise_id option[selected]') == franchise
  end

  def find_dealers_near location, franchise:
    select franchise, from: 'franchise_id'
    fill_in 'branch_location', with: "#{location}\t"
    refute_selector('.pac-container')
    click_button 'Find a dealer'
  end

  def number_of_branches_shown
    all('.ac-card').count
  end

  def on_find_a_dealer_page
    visit '/find-a-dealer'
  end

  def on_find_a_dealer_page?
    current_path.include? '/find-a-dealer/search'
  end

  def vehicle_urls
    all('h2 a').map { |vehicle_link| vehicle_link[:href] }
  end
end
