require 'aws-sdk'

class TestsController < ApplicationController
  def hits
    result = MturkService.list_hits

    render json: ListHitsResponceSerializer.render(result)
  end

  def new
    mturk = client

    question = %{<HTMLQuestion xmlns="http://mechanicalturk.amazonaws.com/AWSMechanicalTurkDataSchemas/2011-11-11/HTMLQuestion.xsd">
  <HTMLContent><![CDATA[
    <!DOCTYPE html>
      <body>
        <script src="https://assets.crowd.aws/crowd-html-elements.js"></script>
        <crowd-form>
          <crowd-classifier
            name="sentiment"
            categories="['Positive', 'Negative', 'Neutral', 'N/A']"
            header="What sentiment does this text convey?"
          >
            <classification-target>
            Everything is wonderful.
            </classification-target>

            <full-instructions header="Sentiment Analysis Instructions">
            <p><strong>Positive</strong>
              sentiment include: joy, excitement, delight</p>
            <p><strong>Negative</strong> sentiment include:
              anger, sarcasm, anxiety</p>
            <p><strong>Neutral</strong>: neither positive or
              negative, such as stating a fact</p>
            <p><strong>N/A</strong>: when the text cannot be
              understood</p>
            <p>When the sentiment is mixed, such as both joy and sadness,
              use your judgment to choose the stronger emotion.</p>
            </full-instructions>

            <short-instructions>
             Choose the primary sentiment that is expressed by the text.
            </short-instructions>
          </crowd-classifier>
        </crowd-form>
      </body>
    </html>
  ]]></HTMLContent>
  <FrameHeight>0</FrameHeight>
</HTMLQuestion>}

    hit_params = {
      title: 'title',
      description: 'description',
      reward: '1',
      assignment_duration_in_seconds: 300,
      lifetime_in_seconds: 300,
      question: question
    }

    result = mturk.create_hit(hit_params)

    p result

    render json: {}
  end

  def balance
    balance = MturkService.balance

    render json: balance
  end

  private
end