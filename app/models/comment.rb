class Comment < ApplicationRecord
  belongs_to :earthquake

  def to_json(options = {})
    super(only: [:id, :body, :earthquake_id]) # Lista los atributos que deseas incluir en la respuesta JSON
  end

end
