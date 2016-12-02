defmodule Socorro.Db.Utils do

    def get_valid_id(mongo_id) do
        if is_map(mongo_id) do
            if mongo_id.__struct__ == BSON.ObjectId || mongo_id.__struct__ == "BSON.ObjectId" do
                mongo_id
            else
                false
            end
        else
            if is_bitstring(mongo_id) do
                decode!(mongo_id)
            else
                false
            end
        end
    end

    def decode!(<< c0,  c1,  c2,  c3,  c4,  c5,
                c6,  c7,  c8,  c9,  c10, c11,
                c12, c13, c14, c15, c16, c17,
                c18, c19, c20, c21, c22, c23 >>) do
        << d(c0)::4,  d(c1)::4,  d(c2)::4,  d(c3)::4,
           d(c4)::4,  d(c5)::4,  d(c6)::4,  d(c7)::4,
           d(c8)::4,  d(c9)::4,  d(c10)::4, d(c11)::4,
           d(c12)::4, d(c13)::4, d(c14)::4, d(c15)::4,
           d(c16)::4, d(c17)::4, d(c18)::4, d(c19)::4,
           d(c20)::4, d(c21)::4, d(c22)::4, d(c23)::4 >>
      catch
        :throw, :error ->
          raise ArgumentError
      else
        value ->
          %BSON.ObjectId{value: value}
    end

    @compile {:inline, :d, 1}
    @compile {:inline, :e, 1}

    @chars Enum.concat(?0..?9, ?a..?f)

    for {char, int} <- Enum.with_index(@chars) do
        defp d(unquote(char)), do: unquote(int)
        defp e(unquote(int)),  do: unquote(char)
    end

    for {char, int} <- Enum.with_index(?A..?F) do
        defp d(unquote(char)), do: unquote(int)
    end

    defp d(_), do: throw :error

end
