"""Pay_Table

Revision ID: 92f0207108d3
Revises: 92e71c42e9f5
Create Date: 2020-05-02 21:35:20.826959

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = '92f0207108d3'
down_revision = '92e71c42e9f5'
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_index('ix_pay_Paydate', table_name='pay')
    op.drop_index('ix_pay_planid', table_name='pay')
    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.create_index('ix_pay_planid', 'pay', ['planid'], unique=False)
    op.create_index('ix_pay_Paydate', 'pay', ['Paydate'], unique=False)
    # ### end Alembic commands ###
