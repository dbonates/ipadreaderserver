require 'itunes/receipt'

class ApiController < ApplicationController
  skip_before_filter :authenticate_user!

  respond_to :json

  # Generate protocol.json file with information about all issues and subscription for current Magazine Application 
  #
  # @param [String] id Bundle_identifier of Magazine Application
  # @return JSON with information about all issues and subscription for current Magazine Application 
  def protocol
  	magazine = Magazine.find_by_apps_id(params[:id]) # get current magazine
  	@issues = Issue.includes(:previews, :contents).where(:magazine_id => magazine) # get current magazine issues
  	@subscriptions = Subscription.where(:magazine_id => magazine) # get current magazine subscription options
  	render 'protocol.json' # generate JSON
  end

  # Check receipt data of purchases and return download link if receipt is OK
  #
  # @param [String] data string base64 encoded to check with iTunes
  # @param [String] bundle_id 
  # @param [String] product_identifier current issue, if user subscribed
  # @return JSON status and download_url, if status is "OK"
  def receipt
    magazine = Magazine.find_by_apps_id(params[:id])
    if params[:data]
      data = params[:data]
      begin
	      Itunes.shared_secret = magazine.shared_secret
        receipt = Itunes::Receipt.verify! data, :allow_sandbox_receipt
        puts receipt.inspect
      rescue Itunes::Receipt::VerificationFailed
        render json:{status:'failed'}
      end
      if params[:product_identifier]
        subscription = Subscription.find_by_product_identifier(receipt.product_id)
        issue = Issue.find_by_product_identifier(params[:product_identifier])
        if subscription && issue
          if subscription.magazine.issues.include?(issue)
            render json:{status:'ok',download_url:"#{request.protocol + request.host_with_port+issue.pdf.url}"}
          else
            render json:{status:'failed'}
          end
        else
          render json:{status:'failed'}
        end
      else
        issue = Issue.find_by_product_identifier(receipt.product_id)
        render json:{status:'ok',download_url:"#{request.protocol + request.host_with_port+issue.pdf.url}"} unless issue.nil?
        render json:{status:'failed'} if issue.nil?
      end
    else
      if params[:product_identifier]
        issue = Issue.find_by_product_identifier(params[:product_identifier])
        if issue.free?
          render json:{status:'ok',download_url:"#{request.protocol + request.host_with_port+issue.pdf.url}"}
        else
          if params[:printed]
            # parametro para dizer se eh assinante da impressa
            if params[:printed] == "receipt"
               render json:{status:'ok',download_url:"#{request.protocol + request.host_with_port+issue.pdf.url}"} 
            end
          end
        end
      else
        render json:{status:'failed'}
      end
    end
  end

  # Generate feed.xml file with information about all issues for current Magazine Application 
  #
  # @param [String] id Bundle_identifier of Magazine Application
  # @return XML with information about all issues according Newsstand Atom Feed 1.2 Specification
  def feed
    magazine = Magazine.find_by_apps_id(params[:id]) # get current magazine
    @issues = Issue.includes(:previews, :contents).where(:magazine_id => magazine) # get current magazine issues
    render 'feed.xml'
  end
end
